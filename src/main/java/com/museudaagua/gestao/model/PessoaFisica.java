package com.museudaagua.gestao.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;

@Entity
public class PessoaFisica extends Pessoa {

	@Column(name = "cpf")
	private String cpf;
	
	@Column(name = "rg_num")
	private String numeroRg;
	
	@Column(name = "rg_uf")
	private String estadoRg;
	
	@Column(name = "dt_nasc")
	private Date dataNasc;
	
	
	public PessoaFisica() {
		// TODO Auto-generated constructor stub
	}
	


	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getNumeroRg() {
		return numeroRg;
	}

	public void setNumeroRg(String numeroRg) {
		this.numeroRg = numeroRg;
	}

	public String getEstadoRg() {
		return estadoRg;
	}

	public void setEstadoRg(String estadoRg) {
		this.estadoRg = estadoRg;
	}

	public Date getDataNasc() {
		return dataNasc;
	}

	public void setDataNasc(Date dataNasc) {
		this.dataNasc = dataNasc;
	}
	
	
	
}
