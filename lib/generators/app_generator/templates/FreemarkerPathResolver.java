package app.infrastructure;

import javax.servlet.http.HttpServletRequest;

import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.view.AcceptHeaderToFormat;
import br.com.caelum.vraptor.view.DefaultPathResolver;

@Component
public class FreemarkerPathResolver extends DefaultPathResolver {
	
	public FreemarkerPathResolver(HttpServletRequest request, AcceptHeaderToFormat acceptHeaderToFormat) {
		super(request, acceptHeaderToFormat);
	}

	protected String getPrefix()  {
		return "/WEB-INF/freemarker/";
	}

	protected String getExtension() {
		return "ftl";
	}
}
