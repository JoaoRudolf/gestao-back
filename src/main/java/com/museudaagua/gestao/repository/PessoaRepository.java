package com.museudaagua.gestao.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.museudaagua.gestao.model.Pessoa;

public interface PessoaRepository extends JpaRepository<Pessoa, Long> {

	
}
