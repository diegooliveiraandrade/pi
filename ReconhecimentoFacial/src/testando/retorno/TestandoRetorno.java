package testando.retorno;

import pi.entity.Cliente;

public class TestandoRetorno {
	public static void main(String[] args) {
		
		// Fiz essa classe apenas para retornar o teste de PersonIds
		Cliente cCliente = new Cliente();
		System.out.println(cCliente.getPersonId());
		
		// Vai retornar nulo porque � o campo do formul�rio que est� vazio.
		System.out.println(cCliente.getNome());
	}

}
