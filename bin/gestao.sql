-- MySQL Script generated by MySQL Workbench
-- Sat Feb 19 13:08:09 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb4;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pessoa` (
  `id_pessoa` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) CHARACTER SET 'ascii' NOT NULL,
  `endereco` VARCHAR(255) CHARACTER SET 'ascii' NULL,
  `tel_mov_1` VARCHAR(13) CHARACTER SET 'ascii' NULL,
  `tel_mov_2` VARCHAR(13) CHARACTER SET 'ascii' NULL,
  `tel_fixo_1` VARCHAR(13) CHARACTER SET 'ascii' NULL,
  `tel_fixo_2` VARCHAR(13) CHARACTER SET 'ascii' NULL,
  `observacoes` VARCHAR(255) CHARACTER SET 'ascii' NULL,
  PRIMARY KEY (`id_pessoa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pessoa_fisica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pessoa_fisica` (
  `id_pessoa` INT NOT NULL,
  `cpf` CHAR(11) CHARACTER SET 'ascii' NULL UNIQUE,
  `rg_num` CHAR(11) NULL,
  `rg_uf` CHAR(2) NULL,
  `dt_nasc` DATE NULL,
  PRIMARY KEY (`id_pessoa`),
  CONSTRAINT `fk_pessoa_fisica_pessoa`
    FOREIGN KEY (`id_pessoa`)
    REFERENCES `mydb`.`pessoa` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pessoa_juridica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pessoa_juridica` (
  `id_pessoa` INT NOT NULL,
  `cnpj` CHAR(14) CHARACTER SET 'ascii' NULL UNIQUE,
  `insc_est` VARCHAR(14) NULL,
  PRIMARY KEY (`id_pessoa`),
  CONSTRAINT `fk_pessoa_juridica_pessoa1`
    FOREIGN KEY (`id_pessoa`)
    REFERENCES `mydb`.`pessoa` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

insert into pessoa (nome) values ('teste1.1');
insert into pessoa_fisica (id_pessoa, cpf) values (2, 'teste1.1');

insert into pessoa (nome) values ('zé');
insert into pessoa_juridica (id_pessoa, cnpj) values (2, 'teste2.1');

select * from pessoa;
select * from pessoa_fisica;
select * from pessoa_juridica;

ALTER TABLE pessoa MODIFY
nome VARCHAR(150)
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;



delete from pessoa where id_pessoa <10;
delete from pessoa_fisica where id_pessoa <10;
delete from pessoa_juridica where id_pessoa <10;

select p.id_pessoa, p.nome
from pessoa as p
left join pessoa_fisica as f
on p.id_pessoa = f.id_pessoa;











drop table pessoa_fisica;
drop table pessoa_juridica;
drop table pessoa;
drop table contrato;

drop schema mydb;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

CREATE TABLE IF NOT EXISTS `mydb`.`contrato` (
  `id_contrato` INT NOT NULL,
  `pessoa_id_pessoa` INT NOT NULL,
  `vendedor` VARCHAR(150) NOT NULL,
  `valor` DECIMAL(8,2) NOT NULL,
  `qtd_parcelas` INT NOT NULL,
  `objeto` VARCHAR(1000) NOT NULL,
  `dt_contrato` DATE NOT NULL,
  `prazo_entrega` INT NULL,
  PRIMARY KEY (`id_contrato`),
  INDEX `fk_contrato_pessoa1_idx` (`pessoa_id_pessoa` ASC) VISIBLE,
  CONSTRAINT `fk_contrato_pessoa1`
    FOREIGN KEY (`pessoa_id_pessoa`)
    REFERENCES `mydb`.`pessoa` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;