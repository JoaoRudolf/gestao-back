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
  `cpf` CHAR(11) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL,
  `rg_num` CHAR(11) NULL,
  `rg_uf` CHAR(2) NULL,
  `dt_nasc` DATE NULL,
  `id_pessoa` INT NOT NULL,
  PRIMARY KEY (`id_pessoa`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
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
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC) VISIBLE,
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
  `cond_pgto` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL,
  `objeto` VARCHAR(1000) NOT NULL,
  `dt_contrato` DATE NOT NULL,
  `prazo_entrega` INT NOT NULL,
  `dias_mtgm_necess` INT NOT NULL,
  `dt_conclusao_mtgm` VARCHAR(45) NULL,
  `soma_custos` DECIMAL(8,2) NULL,
  `lucro_bruto` DECIMAL(8,2) NULL,
  `lucro_liquido_mensal_id_lucro` INT NULL,
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

-- -----------------------------------------------------
-- Data for table `mydb`.`pessoa`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (1, 'Montgomery Rudolf', '89046120', 'Rua Artur Grahl', '547', 'casa', 'Velha Central', 'Blumenau', 'SC', '47984088421', '4733255422', 'NULL', 'montgomery@hotmail.com', 'SÃ³cio Administrador');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (2, 'Jonas Bruder', '89046120', 'Rua Artur Gragl', '917', 'casa', 'Velha Central', 'Blumenau', 'SC', '47997975265', '4733665544', 'NULL', 'jonasbr@gmail.com', 'Vendedor');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (3, 'Jackson Funf', '89065300', 'Rua Pomerode', '510', 'ap 203', 'Salto Norte', 'Blumenau', 'SC', '47858745216', '4733254788', '47985648545', 'jackson5@hotmail.com', 'Vendedor');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (4, 'Kelly Pereira', '89040232', 'Rua dos Caçadores', '2512', 'ap 1005', 'Velha', 'Blumenau', 'SC', '47988595654', '4732658984', '', 'kelly_p@gmail.com', 'Vendedor');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (5, 'Claudemir da Silva', '89056210', 'Rua Harry Wruck', '501', 'casa', 'Fortaleza', 'Blumenau', 'SC', '47984545441', '4785655985', 'NULL', 'claudemir23bi@gmail.com', 'Montador');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (6, 'João Soares', '89036340', 'Rua Colombo', '256', 'ap 400', 'Velha', 'Blumenau', 'SC', '47985656545', '4795656565', 'NULL', 'joao_52@yahoo.com.br', 'Montador');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (7, 'Vilmar Andrade', '89031400', 'Rua José Deeke', '981', 'casa', 'Asilo', 'Blumenau', 'SC', '47988565654', '4798656556', 'NULL', 'vilmar_v@gmail.com', 'Montador');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (8, 'Pedro Brasil', '89022000', 'Rua Amazonas', '3312', 'casa', 'Garcia', 'Blumenau', 'SC', '47985654125', '4798565642', 'NULL', 'pedrinho_pdr@gmail.com', 'Montador');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (9, 'CIA Capirava S/A', '89010002', 'Rua XV de Novembro', '1000', 'NULL', 'Centro', 'Blumenau', 'SC', '47999885522', 'NULL', 'NULL', 'NULL', 'NULL');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (10, 'William Shakespeare', '89068001', 'Rua Gerda Dickmann', '13', 'casa', 'Itoupava Central', 'Blumenau', 'SC', '47989845544', 'NULL', 'NULL', 'wiliam@poetas.com', 'NULL');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (11, 'Cláudia Milk', '89037506', 'Rua Hermann Spernau', '415', 'ap 902', 'Água Verde', 'Blumenau', 'SC', '47998456595', '4733224488', '4733224489', 'NULL', 'disponível apenas no período matutino');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (12, 'Renato Prussiano', '89218111', 'Rua Guilherme Lempke', '1333', 'fundos', 'Santo Antônio', 'Joinville', 'SC', '47334452854', '4798745632', 'NULL', 'NULL', 'NULL');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (13, 'Jairo Barbosa', '89027440', 'Rua Avelino Pering', '458', 'ap 24', 'Progresso', 'Blumenau', 'SC', '47945658525', '4733444789', '47984040605', 'jairo@gmail.com', 'confirmar se energia elÃ©trica foi ligada antes de agendar instalaÃ§Ã£o');
INSERT INTO `mydb`.`pessoa` (`id_pessoa`, `nome`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `telefone1`, `telefone2`, `telefone3`, `email`, `observacoes`) VALUES (14, 'Escola Leônidas da Silva', '89012170', 'Rua Victor Konder', '500', 'ap 1500', 'Victor Konder', 'Blumenau', 'SC', '47988747475', '47996456665', 'NULL', 'NULL', 'NULL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`pessoa_fisica`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('35715971495', '8544715', 'SC', '1953-02-25', 1);
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('45698521457', '4587866', 'SC', '1985-07-31', 2);
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('54956512124', '5464654', 'PR', '1982-02-13', 3);
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('98951645466', '5487229', 'SC', '1989-01-18', 4);
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('54549898784', '5646545', 'SC', '1983-11-13', 5);
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('54458989898', '6556565', 'PR', '1975-03-04', 6);
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('54465656599', '9851211', 'SC', '1965-09-14', 7);
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('66553215499', '1216545', 'SC', '1989-06-16', 8);
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('4548786656', '51564654', 'SC', '1984-01-03', 10);
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('8456546544', '995633', 'BA', '1982-03-15', 11);
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('9956665656', '325454', 'SC', '1978-05-01', 12);
INSERT INTO `mydb`.`pessoa_fisica` (`cpf`, `rg_num`, `rg_uf`, `dt_nasc`, `id_pessoa`) VALUES ('9956654448', '6445445', 'SC', '1976-02-06', 13);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`pessoa_juridica`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`pessoa_juridica` (`cnpj`, `insc_est`, `id_pessoa`) VALUES ('33865806000180', '52754214', 9);
INSERT INTO `mydb`.`pessoa_juridica` (`cnpj`, `insc_est`, `id_pessoa`) VALUES ('83654898000115', '84556444', 14);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`contrato`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`contrato` (`id_contrato`, `cliente_id`, `vendedor_id`, `valor`, `cond_pgto`, `objeto`, `dt_contrato`, `prazo_entrega`, `dias_mtgm_necess`, `dt_conclusao_mtgm`, `soma_custos`, `lucro_bruto`, `lucro_liquido_mensal_id_lucro`) VALUES (1, 9, 2, 38000.00, 'Entrada R$ 19.000,00 depósito CC + cheque R$ 19.000,00 para 22/06/2022', 'Móveis para ambientes comerciais em MDF, interno Branco TX e externo Preto TX com Betton, com puxadores acoplados Anodizados, conforme projetos: Sala 1: Mesas para 13 pessoas e cozinha; Sala 2: Mesas para 12 pessoas; Sala 3: Mesa de reunião para 10 pessoas e bancada com painel de TV; Sala 4: Mesas para 6 pessoas e cozinha; Sala 5: Mesas para 15 pessoas;', '2022-04-06', 45, 8, NULL, NULL, NULL, NULL);
INSERT INTO `mydb`.`contrato` (`id_contrato`, `cliente_id`, `vendedor_id`, `valor`, `cond_pgto`, `objeto`, `dt_contrato`, `prazo_entrega`, `dias_mtgm_necess`, `dt_conclusao_mtgm`, `soma_custos`, `lucro_bruto`, `lucro_liquido_mensal_id_lucro`) VALUES (2, 10, 4, 11500.00, 'Entrada R$ 6.500,00 +  R$ 3.000,00 para 20/05/2022 + R$ 2.000,00 para 20/06/2022', 'Dormitório Casal em MDF, interno Branco TX, externo Branco TX com Argila Arauco, duas portas de correr com puxadores acoplados Inox, portas de abrir e gavetas com puxador alça, com painel de cama e criados, conforme projeto;', '2022-04-11', 60, 2, NULL, NULL, NULL, NULL);
INSERT INTO `mydb`.`contrato` (`id_contrato`, `cliente_id`, `vendedor_id`, `valor`, `cond_pgto`, `objeto`, `dt_contrato`, `prazo_entrega`, `dias_mtgm_necess`, `dt_conclusao_mtgm`, `soma_custos`, `lucro_bruto`, `lucro_liquido_mensal_id_lucro`) VALUES (3, 11, 3, 1200.00, 'R$ 600,00 para 13/05/2022 + R$ 600,00 + 13/06/2022', 'Home theater com painel de TV em MDF, interno branco TX, externo Argila com Cacao Araucoo, com puxadores acoplados Inox, conforme projeto;', '2022-04-13', 60, 1, NULL, NULL, NULL, NULL);
INSERT INTO `mydb`.`contrato` (`id_contrato`, `cliente_id`, `vendedor_id`, `valor`, `cond_pgto`, `objeto`, `dt_contrato`, `prazo_entrega`, `dias_mtgm_necess`, `dt_conclusao_mtgm`, `soma_custos`, `lucro_bruto`, `lucro_liquido_mensal_id_lucro`) VALUES (4, 12, 4, 16800.00, 'À vista', 'Cozinha em MDF, interno Branco TX, externo Cacao Chess com Argila Chess Arauco, com corrediças telescópicas, dobradiças com amortecedor e com puxadores acoplados Inox, conforme projeto; Granito para cozinha cor Preto São Gabriel, tampos, rodapés e rodapia sem cuba;', '2022-04-15', 90, 4, NULL, NULL, NULL, NULL);

COMMIT;

