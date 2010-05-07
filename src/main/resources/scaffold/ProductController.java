import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;

@Resource
public class ProductController {
	
	private Result result;
	
	public ProductController(Result result) {
		this.result = result;
	}
	
	@Post
	@Path("/products")
	public void create() {
		result.redirectTo(ProductController.class).list();
	}
	
	@Get
	@Path("/products")
	public void list() {
		
	}
}
