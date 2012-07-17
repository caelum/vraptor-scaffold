class DependencyManager

  attr_accessor :options

	def initialize(options)
		@options = options
  end

	def dependencies
		dependencies_per_project = {"default" => DefaultDependencies,
																"gae" => GaeDependencies,
																"heroku" => HerokuDependencies}

    dependencies_per_project.fetch(project_style).new(@options)
	end

	private
  def project_style
		if @options[:heroku]
			return "heroku"
		elsif @options[:gae]
			return "gae"
		else
			return "default"
		end
  end

end
