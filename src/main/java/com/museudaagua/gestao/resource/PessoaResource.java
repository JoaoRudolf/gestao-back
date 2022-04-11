package com.museudaagua.gestao.resource;

import java.net.URI;
import java.util.List;


import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.museudaagua.gestao.model.Pessoa;
import com.museudaagua.gestao.model.PessoaFisica;
import com.museudaagua.gestao.model.PessoaJuridica;
import com.museudaagua.gestao.repository.PessoaRepository;

//import javax.validation.Valid;

@RestController
@RequestMapping("/pessoas")
public class PessoaResource {
	
	
	@Autowired
	private PessoaRepository pessoaRepository;
	
	@GetMapping
	public List<Pessoa> listar() {
		return pessoaRepository.findAll();
	}
	
	@GetMapping("/{id}")
	public Pessoa buscarPeloId(@PathVariable Long id) {
		return pessoaRepository.findById(id).orElse(null);
	}
	
	
//	@PostMapping("/fisica")
//	@ResponseStatus(HttpStatus.CREATED)
//	public void criarFisica(@RequestBody PessoaFisica pessoaFisica) {
//		pessoaRepository.save(pessoaFisica);
//	}
	
	@PostMapping("/fisica")     
	@ResponseStatus(HttpStatus.CREATED)
	public ResponseEntity<PessoaFisica> criarFisica(@Valid @RequestBody PessoaFisica pessoaFisica, HttpServletResponse response) {
		PessoaFisica pessoaFisicacaSalva = pessoaRepository.save(pessoaFisica);
		URI uri = ServletUriComponentsBuilder
				.fromCurrentRequestUri()
				.path("/{codigo}")
				.buildAndExpand(pessoaFisicacaSalva.getId())
				.toUri();
		response.setHeader("Location", uri.toASCIIString());
		return ResponseEntity.created(uri).body(pessoaFisicacaSalva);
	}

	
//	@PostMapping("/juridica")
//	@ResponseStatus(HttpStatus.CREATED)
//	public void criarJuridica(@RequestBody PessoaJuridica pessoaJuridica) {
//		pessoaRepository.save(pessoaJuridica);
//	}
	
//	método criarJuridica, mas com resposta
	@PostMapping("/juridica")     
	@ResponseStatus(HttpStatus.CREATED)
	public ResponseEntity<PessoaJuridica> criarJuridica(@Valid @RequestBody PessoaJuridica pessoaJuridica, HttpServletResponse response) {
		PessoaJuridica pessoaJuridicaSalva = pessoaRepository.save(pessoaJuridica);
		URI uri = ServletUriComponentsBuilder
				.fromCurrentRequestUri()
				.path("/{codigo}")
				.buildAndExpand(pessoaJuridicaSalva.getId())
				.toUri();
		response.setHeader("Location", uri.toASCIIString());
		return ResponseEntity.created(uri).body(pessoaJuridicaSalva);
	}
	
	@DeleteMapping("/{id}")
	@ResponseStatus(HttpStatus.NO_CONTENT)
	public void remover(@PathVariable Long id) {
		pessoaRepository.deleteById(id);
	}
	
	@PutMapping("/fisica/{id}")
	public ResponseEntity<PessoaFisica> atualizarFisica(@PathVariable Long id, @Valid @RequestBody PessoaFisica pessoa) {
		PessoaFisica pessoaSalva = (PessoaFisica) pessoaRepository.findById(id).orElse(null);
		if (pessoaSalva == null) {
			throw new EmptyResultDataAccessException(1);
		}
		BeanUtils.copyProperties(pessoa, pessoaSalva, "id");
		pessoaRepository.save(pessoaSalva);
		return ResponseEntity.ok(pessoaSalva);	
	}
	
	@PutMapping("/juridica/{id}")
	public ResponseEntity<PessoaJuridica> atualizarJuridica(@PathVariable Long id, @Valid @RequestBody PessoaJuridica pessoa) {
		PessoaJuridica pessoaSalva = (PessoaJuridica) pessoaRepository.findById(id).orElse(null);
		if (pessoaSalva == null) {
			throw new EmptyResultDataAccessException(1);
		}
		BeanUtils.copyProperties(pessoa, pessoaSalva, "id");
		pessoaRepository.save(pessoaSalva);
		return ResponseEntity.ok(pessoaSalva);	
	}
	
	//modelo para atualizar somente um atributo da entidade
	@PutMapping("/{id}")
	@ResponseStatus(HttpStatus.NO_CONTENT)
	public void atualizarNome(@PathVariable Long id, @RequestBody String novoNome) {
		Pessoa pessoaSalva = pessoaRepository.findById(id).orElse(null);
		pessoaSalva.setNome(novoNome);		
		pessoaRepository.save(pessoaSalva);
	}
	
}
