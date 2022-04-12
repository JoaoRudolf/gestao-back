package com.museudaagua.gestao.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.validation.constraints.Size;

@Entity
public class Contrato {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_contrato", updatable = false, nullable = false)
	private Long id;
	

	@JoinColumn(name = "cliente_id", nullable = false)
	@ManyToOne
	private Pessoa cliente;
	
	@JoinColumn(name = "vendedor_id", nullable = false)
	@ManyToOne
	private Pessoa vendedor;
	
	@Column(name = "valor", nullable = false)
	private BigDecimal valor;
	
	@Size(min = 2, max = 255)
	@Column(name = "cond_pgto", nullable = false)
	private String condPgto;
	
	@Column(name = "objeto", nullable = false)
	private String objeto;
	
	@Column(name = "dt_contrato", nullable = false)
	private LocalDate dataContrato;
	
	@Column(name = "prazo_entrega", nullable = false)
	private int prazoEntrega;
	
	@Column(name = "dias_mtgm_necess", nullable = false)
	private int diasMontagemNecessarios;
	
	@Column(name = "dt_conclusao_mtgm")
	private LocalDate dataConclusaoMontagem;
	
	@Column(name = "soma_custos")
	private BigDecimal somaCustos;
	
	@Column(name = "lucro_bruto")
	private BigDecimal lucroBruto;
	
	@Column(name = "lucro_liquido_mensal_id_lucro")
	private Long apuracaoDoLucroLiquidoMensal;

	public Contrato() {	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Pessoa getCliente() {
		return cliente;
	}

	public void setCliente(Pessoa cliente) {
		this.cliente = cliente;
	}

	public Pessoa getVendedor() {
		return vendedor;
	}

	public void setVendedor(Pessoa vendedor) {
		this.vendedor = vendedor;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

	public String getCondPgto() {
		return condPgto;
	}

	public void setCondPgto(String condPgto) {
		this.condPgto = condPgto;
	}

	public String getObjeto() {
		return objeto;
	}

	public void setObjeto(String objeto) {
		this.objeto = objeto;
	}

	public LocalDate getDataContrato() {
		return dataContrato;
	}

	public void setDataContrato(LocalDate dataContrato) {
		this.dataContrato = dataContrato;
	}

	public int getPrazoEntrega() {
		return prazoEntrega;
	}

	public void setPrazoEntrega(int prazoEntrega) {
		this.prazoEntrega = prazoEntrega;
	}

	public int getDiasMontagemNecessarios() {
		return diasMontagemNecessarios;
	}

	public void setDiasMontagemNecessarios(int diasMontagemNecessarios) {
		this.diasMontagemNecessarios = diasMontagemNecessarios;
	}

	public LocalDate getDataConclusaoMontagem() {
		return dataConclusaoMontagem;
	}

	public void setDataConclusaoMontagem(LocalDate dataConclusaoMontagem) {
		this.dataConclusaoMontagem = dataConclusaoMontagem;
	}

	public BigDecimal getSomaCustos() {
		return somaCustos;
	}

	public void setSomaCustos(BigDecimal somaCustos) {
		this.somaCustos = somaCustos;
	}

	public BigDecimal getLucroBruto() {
		return lucroBruto;
	}

	public void setLucroBruto(BigDecimal lucroBruto) {
		this.lucroBruto = lucroBruto;
	}

	public Long getApuracaoDoLucroLiquidoMensal() {
		return apuracaoDoLucroLiquidoMensal;
	}

	public void setApuracaoDoLucroLiquidoMensal(Long apuracaoDoLucroLiquidoMensal) {
		this.apuracaoDoLucroLiquidoMensal = apuracaoDoLucroLiquidoMensal;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Contrato other = (Contrato) obj;
		return Objects.equals(id, other.id);
	}

}
