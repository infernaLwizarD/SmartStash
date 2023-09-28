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

--
-- Name: item_field_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.item_field_type AS ENUM (
    'text',
    'textarea',
    'select',
    'date',
    'checkbox',
    'radio',
    'file'
);


--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role AS ENUM (
    'admin',
    'user'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: collection_fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.collection_fields (
    id bigint NOT NULL,
    collection_item_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    field_values text DEFAULT '--- []
'::text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    discarded_at timestamp without time zone,
    field_type public.item_field_type,
    label character varying,
    show_tooltip boolean DEFAULT false,
    tooltip character varying,
    is_numeric boolean DEFAULT false,
    no_format boolean DEFAULT false,
    "precision" integer,
    min_value integer,
    max_value integer,
    step integer,
    default_value character varying
);


--
-- Name: collection_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.collection_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: collection_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.collection_fields_id_seq OWNED BY public.collection_fields.id;


--
-- Name: collection_item_hierarchies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.collection_item_hierarchies (
    ancestor_id integer NOT NULL,
    descendant_id integer NOT NULL,
    generations integer NOT NULL
);


--
-- Name: collection_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.collection_items (
    id bigint NOT NULL,
    label character varying,
    creator_id bigint NOT NULL,
    parent_id integer,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    discarded_at timestamp without time zone
);


--
-- Name: collection_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.collection_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: collection_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.collection_items_id_seq OWNED BY public.collection_items.id;


--
-- Name: collection_values; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.collection_values (
    id bigint NOT NULL,
    collection_item_id bigint NOT NULL,
    collection_field_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    value text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    discarded_at timestamp without time zone
);


--
-- Name: collection_values_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.collection_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: collection_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.collection_values_id_seq OWNED BY public.collection_values.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    username character varying,
    role public.user_role,
    discarded_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: collection_fields id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_fields ALTER COLUMN id SET DEFAULT nextval('public.collection_fields_id_seq'::regclass);


--
-- Name: collection_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_items ALTER COLUMN id SET DEFAULT nextval('public.collection_items_id_seq'::regclass);


--
-- Name: collection_values id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_values ALTER COLUMN id SET DEFAULT nextval('public.collection_values_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: collection_fields collection_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_fields
    ADD CONSTRAINT collection_fields_pkey PRIMARY KEY (id);


--
-- Name: collection_items collection_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_items
    ADD CONSTRAINT collection_items_pkey PRIMARY KEY (id);


--
-- Name: collection_values collection_values_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_values
    ADD CONSTRAINT collection_values_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_collection_fields_on_collection_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collection_fields_on_collection_item_id ON public.collection_fields USING btree (collection_item_id);


--
-- Name: index_collection_fields_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collection_fields_on_creator_id ON public.collection_fields USING btree (creator_id);


--
-- Name: index_collection_fields_on_discarded_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collection_fields_on_discarded_at ON public.collection_fields USING btree (discarded_at);


--
-- Name: index_collection_items_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collection_items_on_creator_id ON public.collection_items USING btree (creator_id);


--
-- Name: index_collection_items_on_discarded_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collection_items_on_discarded_at ON public.collection_items USING btree (discarded_at);


--
-- Name: index_collection_values_on_collection_field_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collection_values_on_collection_field_id ON public.collection_values USING btree (collection_field_id);


--
-- Name: index_collection_values_on_collection_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collection_values_on_collection_item_id ON public.collection_values USING btree (collection_item_id);


--
-- Name: index_collection_values_on_creator_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collection_values_on_creator_id ON public.collection_values USING btree (creator_id);


--
-- Name: index_collection_values_on_discarded_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_collection_values_on_discarded_at ON public.collection_values USING btree (discarded_at);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_discarded_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_discarded_at ON public.users USING btree (discarded_at);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_username ON public.users USING btree (username);


--
-- Name: item_anc_desc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX item_anc_desc_idx ON public.collection_item_hierarchies USING btree (ancestor_id, descendant_id, generations);


--
-- Name: item_desc_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX item_desc_idx ON public.collection_item_hierarchies USING btree (descendant_id);


--
-- Name: collection_values fk_rails_1cca46c64e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_values
    ADD CONSTRAINT fk_rails_1cca46c64e FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: collection_fields fk_rails_2df3194bfe; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_fields
    ADD CONSTRAINT fk_rails_2df3194bfe FOREIGN KEY (collection_item_id) REFERENCES public.collection_items(id);


--
-- Name: collection_values fk_rails_417827dd31; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_values
    ADD CONSTRAINT fk_rails_417827dd31 FOREIGN KEY (collection_field_id) REFERENCES public.collection_fields(id);


--
-- Name: collection_values fk_rails_77824f934d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_values
    ADD CONSTRAINT fk_rails_77824f934d FOREIGN KEY (collection_item_id) REFERENCES public.collection_items(id);


--
-- Name: collection_fields fk_rails_981f185c9d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_fields
    ADD CONSTRAINT fk_rails_981f185c9d FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- Name: collection_items fk_rails_ea0148d071; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_items
    ADD CONSTRAINT fk_rails_ea0148d071 FOREIGN KEY (creator_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20230207182811'),
('20230209091919'),
('20230215182412'),
('20230313181755'),
('20230608113327'),
('20230713185945'),
('20230821202540'),
('20230823203909'),
('20230823211123'),
('2023091311514255'),
('20230924201356');


