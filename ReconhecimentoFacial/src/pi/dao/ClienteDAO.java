package pi.dao;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import pi.entity.Cliente;

@Repository
public class ClienteDAO {
	@PersistenceContext
	EntityManager manager;

	public int inserirCliente(Cliente cliente) throws IOException {
		manager.persist(cliente);
		return cliente.getId();
	}

	public Cliente buscarCliente(int id) throws IOException {
		return manager.find(Cliente.class, id);
	}

	public Cliente atualizarCliente(Cliente cliente) throws IOException {
		System.out.println(cliente);
		manager.merge(cliente);
		return cliente;
	}

	public void removerCliente(int id) throws IOException {
		manager.remove(manager.find(Cliente.class, id));
	}

	public List<Cliente> listarCliente(String chave) throws IOException {

		String jpql = "select c from Cliente c where c.personId like :chave";
		Query query = manager.createQuery(jpql);
		query.setParameter("chave", "%" + chave + "%");

		List<Cliente> result = query.getResultList();

		return result;
	}

	public List<Cliente> listarClientes() throws IOException {
		return manager.createQuery("select c from Cliente c").getResultList();
	}

	public List<Cliente> buscarPerson(String personId) throws IOException {
		Query query = manager.createQuery("select c FROM Cliente c where c.personId like :chave");
		query.setParameter("chave", "%" + personId + "%");
		return query.getResultList();
	}

	// BUSCA POR PERSONID

	public Cliente buscarClientePersonId(String personId) throws IOException {
		return manager.find(Cliente.class, personId);
	}

}
