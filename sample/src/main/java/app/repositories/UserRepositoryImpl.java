package app.repositories;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;

import app.models.User;
import br.com.caelum.vraptor.ioc.Component;

@Component
public class UserRepositoryImpl extends Repository<User, Long> implements UserRepository {

	UserRepositoryImpl(EntityManager entityManager) {
		super(entityManager);
	}

	public User login(String email, String password) {
		try {
			//FIXME: Dont use password in plain text format!!
			Query query = entityManager.createQuery("from User where email = :email and password = :password");
			query.setParameter("email", email);
			query.setParameter("password", password);

			return (User) query.getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}
}