-- Exercício
-- 1.2 Associe um trigger de DELETE à tabela. Quando um DELETE for executado, o trigger
-- deve atribuir FALSE à coluna ativo das linhas envolvidas. Além disso, o trigger não deve
-- permitir que nenhuma pessoa seja removida.

-- Criando trigger
CREATE TRIGGER trg_delete_pessoa
BEFORE DELETE ON tb_pessoa
FOR EACH ROW 
EXECUTE FUNCTION trg_delete_pessoa()


-- Criando Função 
CREATE OR REPLACE FUNCTION trg_delete_pessoa()
RETURNS TRIGGER 
LANGUAGE plpgsql AS $$
BEGIN
    IF OLD.nao_pode_ser_removida THEN
        RAISE EXCEPTION 'Não é permitido remover esta pessoa.';
    ELSE
        UPDATE tb_pessoa
        SET ativo = FALSE
        WHERE cod_pessoa = OLD.cod_pessoa;
        RETURN OLD;
    END IF;
END;
$$


-- 1.1 Adicione uma coluna à tabela tb_pessoa chamada ativo. Ela indica se a pessoa está
-- ativa no sistema ou não. Ela deve ser capaz de armazenar um valor booleano. Por padrão,
-- toda pessoa cadastrada no sistema está ativa. Se necessário, consulte o Link 1.1.1.

ALTER TABLE tb_pessoa ADD ativo BOOLEAN;

-- esta update irá falhar
-- UPDATE tb_pessoa SET saldo = -100 WHERE cod_pessoa = 1;

-- SELECT * FROM tb_pessoa

-- INSERT INTO tb_pessoa
-- (nome, idade, saldo)
-- VALUES
-- ('João', 20, 100),
-- ('Pedro', 22, -100),
-- ('Maria', 22, 400);


-- Criando o trigger
-- CREATE TRIGGER tg_validador_de_saldo
-- BEFORE INSERT OR UPDATE ON tb_pessoa
-- FOR EACH ROW
-- EXECUTE PROCEDURE fn_validador_de_saldo()


-- Criando função saldo negativo 
-- CREATE OR REPLACE FUNCTION fn_validador_de_saldo()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql AS $$
-- BEGIN
-- 	IF NEW.saldo >= 0 THEN
-- 		RETURN NEW;
-- 	ELSE
-- 		RAISE NOTICE 'Valor de saldor R$% inválido', NEW.saldo;
-- 		RETURN NULL;
-- 	END IF;
-- END;
-- $$

-- Criando a tabela auditoria 
-- DROP TABLE IF EXISTS tb_auditoria;
-- CREATE TABLE IF NOT EXISTS tb_auditoria(
-- 	cod_auditoria SERIAL PRIMARY KEY,
-- 	cod_pessoa INT NOT NULL,
-- 	idade INT NOT NULL,
-- 	saldo_antigo NUMERIC (10, 2),
-- 	saldo_atual NUMERIC(10, 2)
-- );



-- Criando a tabela pessoa
-- DROP TABLE IF EXISTS tb_pessoa;
-- CREATE TABLE IF NOT EXISTS tb_pessoa(
-- 	cod_pessoa SERIAL PRIMARY KEY,
-- 	nome VARCHAR(200) NOT NULL,
-- 	idade INT NOT NULL,
-- 	saldo NUMERIC(10, 2) NOT NULL
-- );


-- CREATE OR REPLACE TRIGGER tg_antes_do_insert
-- BEFORE INSERT OR UPDATE ON tb_teste_trigger
-- FOR EACH STATEMENT
-- EXECUTE FUNCTION
-- 	fn_antes_de_um_insert('Antes: v1', 'Antes: v2');
	
-- CREATE OR REPLACE TRIGGER tg_depois_do_insert
-- AFTER INSERT OR UPDATE ON tb_teste_trigger
-- FOR EACH STATEMENT
-- EXECUTE PROCEDURE 
-- 	fn_depois_de_um_insert('Depois: V1', 'Depois: V2', 'Depois: V3');


-- removendo todos os dados
-- DELETE FROM tb_teste_trigger;

--visualizar detalhes do sequence usado na geração de valores para a tabela
-- SELECT * FROM tb_teste_trigger_cod_teste_trigger_seq;


-- Começa do 1 de novo. Use WITH n para começar de n
-- ALTER SEQUENCE tb_teste_trigger_cod_teste_trigger_seq RESTART WITH 1;

-- INSERT INTO tb_teste_trigger(texto)
-- VALUES ('mais um teste');

-- CREATE OR REPLACE TRIGGER tg_antes_de_um_insert2
-- BEFORE INSERT ON tb_teste_trigger
-- FOR EACH STATEMENT
-- EXECUTE PROCEDURE fn_antes_de_um_insert();

-- CREATE OR REPLACE TRIGGER tg_depois_do_insert2
-- AFTER INSERT ON tb_teste_trigger
-- FOR EACH STATEMENT
-- EXECUTE FUNCTION fn_depois_de_um_insert();


-- SELECT * FROM tb_teste_trigger;

-- INSERT INTO tb_teste_trigger (texto) VALUES ('testando trigger..');


--depois o vínculo da função à tabela
-- CREATE OR REPLACE TRIGGER tg_depois_do_insert
-- AFTER INSERT ON tb_teste_trigger
-- --também pode sem o EACH
-- FOR STATEMENT
-- EXECUTE FUNCTION fn_depois_de_um_insert();


--primeiro a função
-- CREATE OR REPLACE FUNCTION fn_depois_de_um_insert()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql AS $$
-- BEGIN
-- 	RAISE NOTICE 'Trigger foi chamado depois do INSERT!!';
-- 	RETURN NULL;
-- END;
-- $$

-- CREATE OR REPLACE FUNCTION fn_antes_de_um_insert()
-- RETURNS TRIGGER LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- 	RAISE NOTICE 'Trigger foi chamado antes de um insert';
-- 	RETURN NULL;
-- END;
-- $$

-- INSERT INTO tb_teste_trigger (texto) VALUES ('testando trigger..');

-- CREATE OR REPLACE TRIGGER tg_antes_do_insert
-- BEFORE INSERT ON tb_teste_trigger
-- FOR EACH STATEMENT
-- -- não vale fazer ROUTINE 
-- EXECUTE PROCEDURE fn_antes_de_um_insert();
-- -- EXECUTE FUNCTION fn_antes_de_um_insert();

--esta função especifica o que o trigger vai fazer
--observe que a function é independente do momento em que o trigger vai disparar
--pode não ser uma boa ideia incluir essa informação (antes de um insert) em seu nome,
-- portanto
-- CREATE OR REPLACE FUNCTION fn_antes_de_um_insert() RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- --aqui escrevemos o que o trigger deve fazer
-- RAISE NOTICE 'Trigger foi chamado antes do INSERT!!';
-- --mais sobre isso adiante
-- RETURN NULL;
-- END;
-- $$


-- INSERT INTO tb_teste_trigger(texto) VALUES ('oi');

-- SELECT * FROM tb_teste_trigger;

-- CREATE TABLE tb_teste_trigger(
-- cod_teste_trigger SERIAL PRIMARY KEY,
-- texto VARCHAR(200)
-- );
