package com.museudaagua.gestao.model;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;

@Entity
public class Agendamento {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_agendamento", updatable = false, nullable = false)
	private Long id;

	@NotNull
	@JoinColumn(name = "contrato_id")
	@ManyToOne
	private Contrato contrato;
	
	@Column(name = "dt_inicio")
	private LocalDate dataInicio;
	
	@Column(name = "dias_agenda")
	private int diasNaAgenda;
	
	@NotNull
	@Enumerated(EnumType.STRING)
	private Status status;
	
}
