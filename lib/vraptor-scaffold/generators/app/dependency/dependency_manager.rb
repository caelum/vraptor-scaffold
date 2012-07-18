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
		return "heroku" if @options[:heroku]
		return "gae" if @options[:gae]

		"default"
  end

end
