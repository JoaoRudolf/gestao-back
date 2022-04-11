package com.museudaagua.gestao.resource;

import java.net.URI;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.museudaagua.gestao.model.Contrato;
import com.museudaagua.gestao.repository.ContratoRepository;

@RestController
@RequestMapping("/contratos")
public class ContratoResource {

	@Autowired
	private ContratoRepository contratoRepository;
	
	@GetMapping
	public List<Contrato> listar() {
		return contratoRepository.findAll();
	}
	
	@GetMapping("/{id}")
	public Contrato buscarPeloId(@PathVariable Long id) {
		return contratoRepository.findById(id).orElse(null);
	}
	
	@PostMapping     
	@ResponseStatus(HttpStatus.CREATED)
	public ResponseEntity<Contrato> criarContrato(@Valid @RequestBody Contrato contrato, HttpServletResponse response) {
		Contrato contratoSalvo = contratoRepository.save(contrato);
		URI uri = ServletUriComponentsBuilder
				.fromCurrentRequestUri()
				.path("/{id}")
				.buildAndExpand(contratoSalvo.getId())
				.toUri();
		response.setHeader("Location", uri.toASCIIString());
		return ResponseEntity.created(uri).body(contratoSalvo);
	}
	
}
