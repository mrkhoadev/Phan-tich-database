--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content text NOT NULL,
    teacher_id integer NOT NULL,
    active integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    description text
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.courses ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    bio text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.teacher OWNER TO postgres;

--
-- Name: teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.teacher ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.teacher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (id, name, content, teacher_id, active, created_at, updated_at, description) FROM stdin;
6	HTML	test	1	1000000	2023-12-31 23:42:08.663406+07	2023-12-31 23:42:08.663406+07	\N
7	CSS	test	2	2000000	2023-12-31 23:42:08.663406+07	2023-12-31 23:42:08.663406+07	\N
8	JAVASCIPT	test	3	3000000	2023-12-31 23:42:08.663406+07	2023-12-31 23:42:08.663406+07	\N
\.


--
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher (id, name, bio, created_at, updated_at) FROM stdin;
1	Hoàng An	giảng viên	2023-12-31 23:41:59.714358+07	2023-12-31 23:41:59.714358+07
3	Nam	Trợ giảng 2	2023-12-31 23:41:59.714358+07	2023-12-31 23:46:04.751665+07
2	Dương	Trợ giảng 1	2023-12-31 23:41:59.714358+07	2023-12-31 23:47:06.852247+07
\.


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_id_seq', 8, true);


--
-- Name: teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teacher_id_seq', 3, true);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (id);


--
-- Name: courses courses_teacher_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_teacher_id_foreign FOREIGN KEY (teacher_id) REFERENCES public.teacher(id) NOT VALID;


--
-- PostgreSQL database dump complete
--
-- Phần yêu cầu bài tập
-- Thêm trường description
ALTER TABLE courses ADD COLUMN description TEXT;

-- Đổi tên trường detail thành content và ràng buộc chuyển thành NOT NULL
ALTER TABLE courses
    RENAME COLUMN detail TO content;

-- Chuyển đổi ràng buộc của cột content thành NOT NULL
ALTER TABLE courses
    ALTER COLUMN content SET NOT NULL;
	
UPDATE teacher
SET bio = 'Trợ giảng 2', updated_at = now()
WHERE id = 3

UPDATE teacher
SET bio = 'Trợ giảng 1', updated_at = now()
WHERE id = 2

SELECT t.id, t.name, t.bio, c.name, c.active, t.created_at, t.updated_at FROM teacher AS t
LEFT JOIN courses AS c ON t.id = c.teacher_id