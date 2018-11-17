package pi.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pi.dao.AzureDAO;
import pi.dao.ClienteDAO;
import pi.entity.Cliente;

@Service
public class ClienteService {

	ClienteDAO clienteDAO = new ClienteDAO();
	AzureDAO azureDAO = new AzureDAO();

	@Autowired
	public ClienteService(ClienteDAO cliDAO) {
		clienteDAO = cliDAO;
	}

	public void training() {
		azureDAO.training();
	}

	public void identifyCliente(String urlFoto) {
		azureDAO.identifyCliente(azureDAO.detectCliente(urlFoto));
	}

	public String identifyCliente(File file) throws IOException {

		return azureDAO.identifyCliente(azureDAO.detectClienteFile(file));

	}

	@Transactional
	public Cliente updateCliente(Cliente cliente) throws IOException {
		clienteDAO.atualizarCliente(cliente);
		return cliente;
	}

	@Transactional
	public void deleteCliente(int id) throws IOException {
		clienteDAO.removerCliente(id);
	}

	public Cliente findClienteToId(int id) throws IOException {
		return clienteDAO.buscarCliente(id);
	}

	public List<Cliente> listClienteToChave(String chave) throws IOException {
		return clienteDAO.listarCliente(chave);

	}

	public List<Cliente> listCliente() throws IOException {
		return clienteDAO.listarClientes();
	}

	public List<Cliente> buscarPerson(String personId) throws IOException {
		return clienteDAO.buscarPerson(personId);
	}

	/*
	 * INSERE O CLIENTE NO AZURE, RECEBE O PERSONID E SALVA JUNTO COM OS DADOS DO
	 * CLIENTE NO BANCO
	 */
	@Transactional
	public Cliente inserirCliente(Cliente cliente) throws IOException {
		cliente.setPersonId(azureDAO.insertCliente(cliente.getNome(), cliente.getEstado()));
		System.out.println("PersonID no Azure: " + cliente.getPersonId());
		int id = clienteDAO.inserirCliente(cliente);
		cliente.setId(id);
		return cliente;
	}

	/*
	 * RECEBE ENDERECO DA FOTO EM STRING E ENVIA PARA O AZURE
	 */
	public void insertClientePhoto(Cliente cliente, String photo) throws IOException {
		azureDAO.insertPhotoClienteLocal(cliente.getPersonId(), (cliente.getNome() + " " + cliente.getEstado()), photo);
	}

	public void insertPhotoClienteFile(Cliente cliente, File photo) throws IOException {
		azureDAO.insertPhotoClienteFile(cliente.getPersonId(), (cliente.getNome() + " " + cliente.getEstado()), photo);
	}

	// BUSCAR POR PERSONID

	public Cliente personIdFind(String personId) throws IOException {
		return clienteDAO.buscarClientePersonId(personId);
	}

}
