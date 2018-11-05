package pi.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.validation.Valid;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import pi.dao.AzureDAO;
import pi.entity.Cliente;
import pi.service.ClienteService;

@Controller
public class ManterClienteController {
	@Autowired
	private ClienteService clienteService;

	@RequestMapping("/")
	public String iniciar() {
		return "index";
	}

	@RequestMapping("/index")
	public String iniciarA() {
		return "index";
	}

	@RequestMapping("/criarCliente")
	public String criarCliente() {
		return "CriarCliente";
	}
	
	@RequestMapping("/identificarCliente")
	public String buscarCliente() {
		return "BuscarCliente";
	}

	@Transactional
	@RequestMapping("/createClientePhoto")
	public String createClientePhoto(@Valid Cliente cliente,
			@RequestParam(required = false, name = "file") String photo, BindingResult erros, Model model) {

		try {
			if (!erros.hasErrors()) {

				// salva cliente no banco
				cliente = clienteService.inserirCliente(cliente);

				// Prepare string
				String base64Image = photo.split(",")[1];

				// This will decode the String which is encoded by using Base64 class
				byte[] imageByte = Base64.decodeBase64(base64Image);

				// save the image to folder
				String directory = "C:/Users/dietk/Desktop/fotos/" + cliente.getNome() + ".png";

				// conversao file
				File foto = new File(directory);
				foto.createNewFile();
				FileOutputStream fos = new FileOutputStream(foto);
				fos.write(imageByte);
				fos.close();

				// Enviando imagem para a API
				clienteService.insertPhotoClienteFile(cliente, foto);

				// Trainning API
				clienteService.training();

				// atualizando o model
				model.addAttribute("cliente", cliente);
				return "VisualizarCliente";

			} else {

				return "CriarCliente";
			}
		} catch (IOException e) {
			e.printStackTrace();
			model.addAttribute("erro", e);
			return "Erro";
		}
	}

	@RequestMapping("/catchPhoto")
	public String catchPhoto(Cliente cliente, @RequestParam(required = false, name = "file") String photo,
			BindingResult erros, Model model) {

		try {

			if (!erros.hasErrors()) {

				// prepare string
				String base64Image = photo.split(",")[1];

				// This will decode the String which is encoded by using Base64 class
				byte[] imageByte = Base64.decodeBase64(base64Image);

				// save the image to folder
				String directory = "C:/Users/dietk/Desktop/fotos/" + cliente.getNome() + ".png";

				// conversao file
				File foto = new File(directory);
				foto.createNewFile();
				FileOutputStream fos = new FileOutputStream(foto);
				fos.write(imageByte);
				fos.close();
				clienteService.identifyCliente(foto);
				System.out.println(cliente.getNome());
				return "VisualizarCliente";

			} else {

				System.out.println(cliente.getNome());

				return "deuRuim";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("erro", e);
			return "Erro";
		}
	}

	@RequestMapping("/identifica")
	public String identifica() {
		return "CatchPhotos";
	}

	/*
	 * INSERINDO CLIENTE NO BANCO DE DADOS E NA API
	 * 
	 */

	@RequestMapping(method = RequestMethod.POST, value = "rest/cliente", headers = "Accept=application/json")
	public @ResponseBody Cliente insertCliente(@RequestBody Cliente cliente, Model model) throws IOException {

		cliente = clienteService.inserirCliente(cliente);

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

	/*
	 * IDENTIFICA CLIENTE ATRAVES DA FOTO
	 */

	/*
	
	@RequestMapping(method = RequestMethod.POST, value = "rest/cliente/identifica", headers = "Accept=application/json")
	public @ResponseBody String identifyCliente(@RequestBody String photo, Model model) throws IOException {
		try {

			AzureDAO azureDAO = new AzureDAO();
			azureDAO.training();

			// Aqui � acionado o IdentificaPessoa que precisa de um FaceID, obtido atrav�s
			// do DetectaPessoa
			// IMPORTANTE: ajustar para receber a foto ou array de fotos, o que for
			// necessario
			String testeFoto = photo;
			String response = azureDAO.identifyCliente(azureDAO.detectClienteToUrl(testeFoto));

			return response;

		} catch (Exception e) {
			throw e;
		}

	}
	
	*/

}
