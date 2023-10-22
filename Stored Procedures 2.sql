-- Altera o delimitador temporariamente para '$'
DELIMITER $

-- Criação da stored procedure para inserir alunos
CREATE PROCEDURE Insert_alunos(
    nome_aluno VARCHAR(70),
    ra_aluno VARCHAR(70),
    email_aluno VARCHAR(45)
)
BEGIN
    -- Insere um novo aluno na tabela 'alunos' com os valores passados como argumentos
    INSERT INTO alunos (nome, ra, email) VALUES (nome_aluno, ra_aluno, email_aluno);
END $

DELIMITER $

-- Criação da stored procedure para inserir cursos
CREATE PROCEDURE Insert_cursos(
    nome_curso VARCHAR(70)
)
BEGIN
    -- Insere um novo curso na tabela 'cursos' com o nome passado como argumento
    INSERT INTO cursos (nome) VALUES (nome_curso);
END $

-- Criação da stored procedure para inserir professores
CREATE PROCEDURE Insert_professores(
    nome_professor VARCHAR(70),
    salario_professor DECIMAL(10, 2)
)
BEGIN
    -- Insere um novo professor na tabela 'professores' com o nome e salário passados como argumentos
    INSERT INTO professores (nome, salario) VALUES (nome_professor, salario_professor);
END $

-- Restaura o delimitador padrão para ';'
DELIMITER ;


CALL Insert_alunos('Homem de Ferro', '0004', 'homem.de.ferro@facens.br');
CALL Insert_alunos('Homem de Ferro', '0004', 'homem.de.ferro@facens.br');

CALL Insert_alunos('Viúva Negra', '0005', 'viuva.negra@facens.br');
CALL Insert_alunos('Thor', '0006', 'thor@facens.br');
CALL Insert_alunos('Superman', '0007', 'superman@facens.br');
CALL Insert_alunos('Mulher Maravilha', '0008', 'mulher.maravilha@facens.br');
CALL Insert_alunos('Flash', '0009', 'flash@facens.br');
CALL Insert_alunos('Goku', '0010', 'goku@facens.br');
CALL Insert_alunos('Natsu Dragneel', '0011', 'natsu.dragneel@facens.br');
CALL Insert_alunos('Monkey D. Luffy', '0012', 'luffy@facens.br');
CALL Insert_alunos('Capitão América', '0013', 'capitao.america@facens.br');
CALL Insert_alunos('Hulk', '0014', 'hulk@facens.br');
CALL Insert_alunos('Doutor Estranho', '0015', 'doutor.estranho@facens.br');
CALL Insert_alunos('Aquaman', '0016', 'aquaman@facens.br');
CALL Insert_alunos('Arqueiro Verde', '0017', 'arqueiro.verde@facens.br');
CALL Insert_alunos('Lanterna Verde', '0018', 'lanterna.verde@facens.br');



CALL Insert_cursos('engenharia das coisas');
CALL Insert_cursos('infermagem para ciborg');
CALL Insert_cursos('arqueologia dos buracos negros');
CALL Insert_cursos('enegenheiro solar');

select * from cursos;

CALL Insert_professores('Tirulipa', 2000.00);
CALL Insert_professores('Caneta Azul', 2000.00);
CALL Insert_professores('Pipoquinha', 2000.00);
CALL Insert_professores('Neymar', 2000.00);


select * from professores;



DROP PROCEDURE Insert_alunos;
DROP PROCEDURE Insert_cursos;

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
drop procedure Insert_alunos;
delete from alunos;
select * from alunos;


