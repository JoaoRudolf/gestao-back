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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pessoa` (
  `id_pessoa` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `cep` VARCHAR(8) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `logradouro` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `numero` VARCHAR(6) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `complemento` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `bairro` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `cidade` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `estado` CHAR(2) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `telefone1` VARCHAR(13) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `telefone2` VARCHAR(13) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `telefone3` VARCHAR(13) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `email` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `observacoes` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  PRIMARY KEY (`id_pessoa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`pessoa_fisica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pessoa_fisica` (
  `cpf` CHAR(11) CHARACTER SET 'ascii' NULL,
  `rg_num` CHAR(11) NULL,
  `rg_uf` CHAR(2) NULL,
  `dt_nasc` DATE NULL,
  `id_pessoa` INT NOT NULL,
  PRIMARY KEY (`id_pessoa`),
  CONSTRAINT `fk_pessoa_fisica_pessoa1`
    FOREIGN KEY (`id_pessoa`)
    REFERENCES `mydb`.`pessoa` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`pessoa_juridica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pessoa_juridica` (
  `cnpj` CHAR(14) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `insc_est` VARCHAR(14) NULL,
  `id_pessoa` INT NOT NULL,
  PRIMARY KEY (`id_pessoa`),
  CONSTRAINT `fk_pessoa_juridica_pessoa1`
    FOREIGN KEY (`id_pessoa`)
    REFERENCES `mydb`.`pessoa` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`lucro_liquido_mensal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lucro_liquido_mensal` (
  `id_lucro` INT NOT NULL AUTO_INCREMENT,
  `mes_comp` VARCHAR(7) NOT NULL,
  `soma_lucro_bruto` DECIMAL(10,2) NULL,
  `soma_despesas` VARCHAR(45) NULL,
  PRIMARY KEY (`id_lucro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contrato` (
  `id_contrato` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NOT NULL,
  `vendedor_id` INT NOT NULL,
  `valor` DECIMAL(8,2) NOT NULL,
  `cond_pgto` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `objeto` VARCHAR(1000) NOT NULL,
  `dt_contrato` DATE NOT NULL,
  `prazo_entrega` INT NOT NULL,
  `dias_mtgm_necess` INT NOT NULL,
  `dt_conclusao_mtgm` VARCHAR(45) NULL,
  `soma_custos` DECIMAL NULL,
  `lucro_bruto` VARCHAR(45) NULL,
  `lucro_liquido_mensal_id_lucro` INT NOT NULL,
  PRIMARY KEY (`id_contrato`),
  INDEX `vendedor_id_idx` (`vendedor_id` ASC) VISIBLE,
  INDEX `cliente_id_idx` (`cliente_id` ASC) VISIBLE,
  INDEX `fk_contrato_lucro_liquido_mensal1_idx` (`lucro_liquido_mensal_id_lucro` ASC) VISIBLE,
  CONSTRAINT `cliente_id`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `mydb`.`pessoa` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `vendedor_id`
    FOREIGN KEY (`vendedor_id`)
    REFERENCES `mydb`.`pessoa` (`id_pessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contrato_lucro_liquido_mensal1`
    FOREIGN KEY (`lucro_liquido_mensal_id_lucro`)
    REFERENCES `mydb`.`lucro_liquido_mensal` (`id_lucro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`agendamento` (
  `id_agendamento` INT NOT NULL AUTO_INCREMENT,
  `contrato_id` INT NOT NULL,
  `dt_inicio` DATE NULL,
  `dias_agenda` VARCHAR(45) NULL,
  `status` VARCHAR(30) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  PRIMARY KEY (`id_agendamento`),
  INDEX `contrato_id_idx` (`contrato_id` ASC) VISIBLE,
  CONSTRAINT `contrato_id`
    FOREIGN KEY (`contrato_id`)
    REFERENCES `mydb`.`contrato` (`id_contrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`custo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`custo` (
  `id_custo` INT NOT NULL AUTO_INCREMENT,
  `contrato_id` INT NOT NULL,
  `descricao` VARCHAR(100) NULL,
  `categoria` VARCHAR(50) NULL,
  `dt_comp` DATE NULL,
  `dt_venc` DATE NULL,
  PRIMARY KEY (`id_custo`),
  INDEX `fk_custo_contrato1_idx` (`contrato_id` ASC) VISIBLE,
  CONSTRAINT `fk_custo_contrato1`
    FOREIGN KEY (`contrato_id`)
    REFERENCES `mydb`.`contrato` (`id_contrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`despesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`despesa` (
  `id_despesa` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NULL,
  `dt_comp` DATE NULL,
  `dt_venc` DATE NULL,
  `lucro_liquido_mensal_id_lucro` INT NOT NULL,
  PRIMARY KEY (`id_despesa`),
  INDEX `fk_despesa_lucro_liquido_mensal1_idx` (`lucro_liquido_mensal_id_lucro` ASC) VISIBLE,
  CONSTRAINT `fk_despesa_lucro_liquido_mensal1`
    FOREIGN KEY (`lucro_liquido_mensal_id_lucro`)
    REFERENCES `mydb`.`lucro_liquido_mensal` (`id_lucro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
