package pi.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import pi.entity.Cliente;
import pi.service.ClienteService;

@Controller
public class RestController {

	@Autowired
	private ClienteService clienteService;

	@RequestMapping(method = RequestMethod.POST, value = "rest/cliente", headers = "Accept=application/json")
	public @ResponseBody Cliente insertCliente(@RequestBody Cliente cliente, Model model, BindingResult erros)
			throws IOException {

		cliente = clienteService.inserirCliente(cliente);

		// Prepare string
		String foto = cliente.getFoto();
		String base64Image = foto.split(",")[1];
		System.out.println("Teste" + foto);

		// This will decode the String which is encoded by using Base64 class
		byte[] imageByte = Base64.decodeBase64(base64Image);

		// salvando arquivo temporariamente
		File foto1 = File.createTempFile("fotos", ".png");
		foto1.createNewFile();
		FileOutputStream fos = new FileOutputStream(foto1);
		fos.write(imageByte);
		fos.close();

		// APAGANDO ARQUIVO TEMPORARIO
		foto1.deleteOnExit();

		// Enviando imagem para a API
		clienteService.insertPhotoClienteFile(cliente, foto1);

		// Trainning API
		clienteService.training();

		// atualizando o model
		model.addAttribute("cliente", cliente);

		return cliente;
	}

	/*
	 * BUSCA POR ID
	 */
	@RequestMapping(method = RequestMethod.GET, value = "rest/cliente/{id}")
	public @ResponseBody Cliente findClienteToId(@PathVariable("id") int id, Model model) throws IOException {
		try {
			Cliente cliente = clienteService.findClienteToId(id);
			model.addAttribute("cliente", cliente);
			return cliente;

		} catch (IOException e) {
			throw e;
		}
	}

	/*
	 * LISTA TODOS OS CLIENTES
	 */
	@RequestMapping(method = RequestMethod.GET, value = "rest/cliente")
	public @ResponseBody List<Cliente> listCliente(Model model) throws IOException {
		try {
			List<Cliente> cliente = clienteService.listCliente();
			model.addAttribute("cliente", cliente);
			return cliente;

		} catch (IOException e) {
			throw e;
		}
	}

	/*
	 * ALTERA DADOS DO CLIENTE
	 */
	@RequestMapping(method = RequestMethod.PUT, value = "rest/cliente", headers = "Accept=application/json")
	public @ResponseBody Cliente updateCliente(@RequestBody Cliente cliente, Model model) throws IOException {
		try {
			Cliente cliente1 = clienteService.updateCliente(cliente);
			model.addAttribute("cliente", cliente1);
			return cliente1;

		} catch (IOException e) {
			throw e;
		}
	}

	/*
	 * DELETA O CLIENTE PELO ID
	 */
	@RequestMapping(method = RequestMethod.DELETE, value = "rest/cliente/{id}")
	public @ResponseBody String removeCliente(@PathVariable("id") int id, Model model) throws IOException {
		try {
			clienteService.deleteCliente(id);

		} catch (IOException e) {
			throw e;
		}
		return "Cliente removido!";
	}

	// BUSCA DE CLIENTE IDENTIFICADO ATRAVES DA FOTO

	@RequestMapping(method = RequestMethod.POST, value = "rest/cliente/identifica", headers = "Accept=application/json")
	public @ResponseBody Cliente identificaCliente(@RequestBody Cliente cliente, Model model, BindingResult erros)
			throws IOException {

		// prepare string
		String foto = cliente.getFoto();
		String base64Image = foto.split(",")[1];

		// This will decode the String which is encoded by using Base64 class
		byte[] imageByte = Base64.decodeBase64(base64Image);

		// conversao file
		// SALVANDO ARQUIVO TEMPORARIO
		File foto1 = File.createTempFile("fotos", ".png");
		foto1.createNewFile();
		FileOutputStream fos = new FileOutputStream(foto1);
		fos.write(imageByte);
		fos.close();

		// APAGANDO ARQUIVO TEMPORARIO
		foto1.deleteOnExit();

		// BUSCA DO CLIENTE ATRAVES DO PERSONID
		String chave = clienteService.identifyCliente(foto1);

		List<Cliente> lista;
		if (chave != null && chave.length() > 0) {
			lista = clienteService.listClienteToChave(chave);
		} else {
			lista = clienteService.listClienteToChave(null);
		}

		model.addAttribute("lista", lista);

		System.out.println(cliente);
		return cliente;

	}

}
