class Day07
  def part1(inputs)
    filesystem = Compiler.new.compile(inputs)

    possible_dirs = filesystem.dir_sizes.filter do |dir_name, dir_size|
      dir_size <= 100000
    end

    possible_dirs.values.sum
  end

  def example_part1
    95437
  end

  def part2(inputs)
    filesystem = Compiler.new.compile(inputs)
    dir_sizes = filesystem.dir_sizes
    unused_space = 70000000 - dir_sizes["/"]
    space_needed = 30000000 - unused_space
    possible_dirs = dir_sizes.select { |dir_name, dir_size| dir_size >= space_needed }
    smallest_dir = possible_dirs.min_by { |dir_name, dir_size| dir_size }.first
    dir_sizes[smallest_dir]
  end

  def example_part2
    24933642
  end
end

class Compiler
  Token = Struct.new(:type, :value)
  Command = Struct.new(:name, :args, :outputs)
  Output = Struct.new(:line)

  def compile(inputs)
    tokens = inputs.split("\n").map(&method(:tokenize))
    ast = build_ast(tokens)
    interpret(ast)
  end

  def tokenize(line)
    parts = line.split(" ")

    case parts
    in "$", *args
      Token.new(:command, args)
    else
      Token.new(:output, parts)
    end
  end

  def build_ast(tokens)
    ast = []

    until tokens.empty?
      token = tokens.shift

      if token.type == :command
        command_name, *args = token.value
        ast << (command = Command.new(command_name, args, []))
        while !tokens.empty? && tokens[0].type == :output
          command.outputs << tokens.shift
        end
      end
    end

    ast
  end

  def interpret(ast)
    filesystem = Filesystem.new

    ast.each do |command|
      case command.name
      when "cd"
        filesystem.cd(command.args.first)
      when "ls"
        filesystem.ls(command.outputs.map(&:value))
      end
    end

    filesystem
  end
end

class Filesystem
  Directory = Struct.new(:parent_dir, :path, :contents) do
    def full_path
      return path if parent_dir.nil?
      ::File.join(parent_dir.full_path, path)
    end

    def walk(&block)
      contents.each do |content|
        case content
        when Directory
          content.walk(&block)
          block.call(self, content)
        when File
          block.call(self, content)
        end
      end
    end
  end

  File = Struct.new(:name, :size)

  attr_reader :cwd, :dirs

  def initialize(cwd = Directory.new(nil, "/", []))
    @cwd = cwd
    @dirs = {}
  end

  def root
    @dirs["/"]
  end

  def cd(dir_path)
    @cwd = dir(cwd, dir_path)
  end

  def ls(outputs = nil)
    return cwd.contents if outputs.nil?

    outputs.each do |output|
      case output
      in ["dir", dir_path]
        cwd.contents << dir(cwd, dir_path)
      in [file_size, file_name]
        cwd.contents << File.new(file_name, file_size.to_i)
      end
    end
  end

  def dir_sizes
    dir_sizes = {}

    root.walk do |dir, item|
      dir_sizes[dir.full_path] ||= 0

      case item
      when Filesystem::Directory
        dir_sizes[dir.full_path] += dir_sizes[item.full_path]
      when Filesystem::File
        dir_sizes[dir.full_path] += item.size
      end
    end

    dir_sizes
  end

  private

  def dir(parent_dir, dir_path)
    full_dir_path = ::File.expand_path(dir_path, parent_dir.full_path)
    @dirs[full_dir_path] ||= Directory.new(parent_dir, dir_path, [])
  end
end
