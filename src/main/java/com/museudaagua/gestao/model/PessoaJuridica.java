package com.museudaagua.gestao.model;

import javax.persistence.Column;
import javax.persistence.Entity;

@Entity
public class PessoaJuridica extends Pessoa {

	@Column(name = "cnpj")
	private String cnpj;
	
	@Column(name = "insc_est")
	private String inscEstadual;

	public PessoaJuridica() {
		// TODO Auto-generated constructor stub
	}
		
	
	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public String getInscEstadual() {
		return inscEstadual;
	}

	public void setInscEstadual(String inscEstadual) {
		this.inscEstadual = inscEstadual;
	}
	
	
	
}
