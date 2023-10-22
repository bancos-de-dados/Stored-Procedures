# Stored Procedures
## Descrição
Crie um banco de dados para armazenar alunos, cursos e professores de uma
universidade

Faça a modelagem do banco e identifique as entidades, seus atributos e relacionamentos;
Crie o modelo físico do banco de dados (script SQL)

Utilize Stored Procedures para automatizar a inserção e seleção dos cursos

O aluno possui um email que deve ter seu endereço gerado automaticamente no seguinte formato:
nome.sobrenome@dominio.com

Como fica o email se duas pessoas tiverem o mesmo nome e sobrenome?

## BD Diagrama:

Diagrama criado para identificar as entidades e seus atributos e relacionamentos

![Diagrama](https://github.com/bancos-de-dados/Stored-Procedures/assets/127689567/6580bc49-f492-493d-be5a-37119afdbe88)

## Codigo:
```SQL

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Stored Procedures
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Stored Procedures
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Stored Procedures` DEFAULT CHARACTER SET utf8 ;
USE `Stored Procedures` ;

-- -----------------------------------------------------
-- Table `Stored Procedures`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stored Procedures`.`cursos` (
  `id_universidade` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`id_universidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stored Procedures`.`alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stored Procedures`.`alunos` (
  `id_alunos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NOT NULL,
  `ra` VARCHAR(70) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_alunos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stored Procedures`.`professores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stored Procedures`.`professores` (
  `id_professores` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NOT NULL,
  `salario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_professores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stored Procedures`.`alunos_has_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stored Procedures`.`alunos_has_cursos` (
  `alunos_id_alunos` INT NOT NULL,
  `cursos_id_universidade` INT NOT NULL,
  PRIMARY KEY (`alunos_id_alunos`, `cursos_id_universidade`),
  INDEX `fk_alunos_has_cursos_cursos1_idx` (`cursos_id_universidade` ASC) VISIBLE,
  INDEX `fk_alunos_has_cursos_alunos_idx` (`alunos_id_alunos` ASC) VISIBLE,
  CONSTRAINT `fk_alunos_has_cursos_alunos`
    FOREIGN KEY (`alunos_id_alunos`)
    REFERENCES `Stored Procedures`.`alunos` (`id_alunos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alunos_has_cursos_cursos1`
    FOREIGN KEY (`cursos_id_universidade`)
    REFERENCES `Stored Procedures`.`cursos` (`id_universidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stored Procedures`.`professores_has_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stored Procedures`.`professores_has_cursos` (
  `professores_id_professores` INT NOT NULL,
  `cursos_id_universidade` INT NOT NULL,
  PRIMARY KEY (`professores_id_professores`, `cursos_id_universidade`),
  INDEX `fk_professores_has_cursos_cursos1_idx` (`cursos_id_universidade` ASC) VISIBLE,
  INDEX `fk_professores_has_cursos_professores1_idx` (`professores_id_professores` ASC) VISIBLE,
  CONSTRAINT `fk_professores_has_cursos_professores1`
    FOREIGN KEY (`professores_id_professores`)
    REFERENCES `Stored Procedures`.`professores` (`id_professores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professores_has_cursos_cursos1`
    FOREIGN KEY (`cursos_id_universidade`)
    REFERENCES `Stored Procedures`.`cursos` (`id_universidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
```




## Store Proecedure curso
foi criado um stored Procedure para automatizar os inserts da tabela "curso" da seguinte forma:

```SQL
DELIMITER $

-- Criação da stored procedure para inserir cursos
CREATE PROCEDURE Insert_cursos(
    nome_curso VARCHAR(70)
)
BEGIN
    -- Insere um novo curso na tabela 'cursos' com o nome passado como argumento
    INSERT INTO cursos (nome) VALUES (nome_curso);
END $
 
DELIMITER;
```
Para inerir os dado via call:
```SQL
CALL Insert_cursos('engenharia das coisas');
CALL Insert_cursos('infermagem para ciborg');
CALL Insert_cursos('arqueologia dos buracos negros');
CALL Insert_cursos('enegenheiro solar');
```

![Cursos](https://github.com/bancos-de-dados/Stored-Procedures/assets/127689567/a2891d51-fd27-4327-94a7-089ca8cf2028)

## Store Proecedure alunos

Abaixo foi utilizado o store procedure para automatizar a função chamada `Insert_alunos` que insere um novo aluno na tabela `alunos`. Ela recebe três detalhes do aluno como entrada: nome, sobrenome e número de registro acadêmico (RA). Em seguida, gera um e-mail temporário combinando esses detalhes e insere o aluno na tabela `alunos`, gerando um identificador único para o aluno inserido.

```SQL

DELIMITER $

CREATE PROCEDURE Insert_alunos(
    nome_aluno VARCHAR(50),
    sobrenome_aluno VARCHAR(50),
    ra_aluno VARCHAR(70)
)
BEGIN
    DECLARE id INT;
    DECLARE email_temp VARCHAR(100);
    
    -- Gera um e-mail temporário usando o nome, sobrenome e RA
    SET email_temp = CONCAT(nome_aluno, '.', sobrenome_aluno, '.', ra_aluno, '@dominio.com');
    
    -- Insere o aluno na tabela
    INSERT INTO alunos (nome, sobrenome, ra, email) VALUES (nome_aluno, sobrenome_aluno, ra_aluno, email_temp);
    
    -- Obtém o ID do aluno inserido
    SET id = LAST_INSERT_ID();
    
END $

DELIMITER ;
```

Para não haber o problema de dois alunos com o mesmo nome e sobrenome na criação foi concat o RA do aluno ao seu email.

para inserir os dados foram chamado o comando call conforme a imagem abaixo:

```SQL
CALL Insert_alunos('Mulher', 'Maravilha', '0124');
CALL Insert_alunos('Batman', 'heroi', '0125');
CALL Insert_alunos('Superman', 'heroi', '0126');
CALL Insert_alunos('Flash', 'heroi', '0127');
CALL Insert_alunos('Aquaman', 'heroi', '0128');
CALL Insert_alunos('Lanterna', 'Verde', '0129');
CALL Insert_alunos('Hulk', 'heroi', '0130');
CALL Insert_alunos('Thor', 'heroi', '0131');
CALL Insert_alunos('Iron', 'Man', '0132');
CALL Insert_alunos('Black', 'Widow', '0133');
CALL Insert_alunos('Captain', 'America', '0134');
CALL Insert_alunos('Spider', 'Man', '0135');
CALL Insert_alunos('Wonder', 'Boy', '0136');
CALL Insert_alunos('Supergirl', 'heroi', '0137');

```


![Alunos](https://github.com/bancos-de-dados/Stored-Procedures/assets/127689567/0b517437-65cd-44fc-a6f0-95ce2ae58b16)





![OIP](https://github.com/bancos-de-dados/Stored-Procedures/assets/127689567/55d69407-ef21-48e6-a071-b47068201ffc)



## Última atualização 22/10/23
