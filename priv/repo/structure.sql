--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4
-- Dumped by pg_dump version 14.5 (Homebrew)

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
-- Name: matchups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.matchups (
    id uuid NOT NULL,
    espn_raw jsonb NOT NULL,
    week_id uuid,
    season_id uuid,
    home_team_id uuid,
    away_team_id uuid,
    home_score character varying(255) NOT NULL,
    away_score character varying(255) NOT NULL,
    playoff_tier_type character varying(255) NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: seasons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.seasons (
    id uuid NOT NULL,
    year character varying(255) NOT NULL,
    first_place_id uuid,
    second_place_id uuid,
    third_place_id uuid,
    last_place_id uuid,
    buy_in integer,
    payouts integer[],
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id uuid NOT NULL,
    espn_raw jsonb NOT NULL,
    espn_id character varying(255) NOT NULL,
    user_id uuid,
    season_id uuid,
    name character varying(255),
    avatar_url character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    espn_raw jsonb NOT NULL,
    espn_id character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: weeks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.weeks (
    id uuid NOT NULL,
    season_id uuid NOT NULL,
    week integer NOT NULL,
    playoff boolean DEFAULT false NOT NULL,
    recap text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: matchups matchups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matchups
    ADD CONSTRAINT matchups_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: seasons seasons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weeks weeks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weeks
    ADD CONSTRAINT weeks_pkey PRIMARY KEY (id);


--
-- Name: matchups_away_team_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX matchups_away_team_id_index ON public.matchups USING btree (away_team_id);


--
-- Name: matchups_home_team_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX matchups_home_team_id_index ON public.matchups USING btree (home_team_id);


--
-- Name: matchups_season_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX matchups_season_id_index ON public.matchups USING btree (season_id);


--
-- Name: matchups_week_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX matchups_week_id_index ON public.matchups USING btree (week_id);


--
-- Name: matchups_week_id_season_id_home_team_id_away_team_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX matchups_week_id_season_id_home_team_id_away_team_id_index ON public.matchups USING btree (week_id, season_id, home_team_id, away_team_id);


--
-- Name: seasons_first_place_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX seasons_first_place_id_index ON public.seasons USING btree (first_place_id);


--
-- Name: seasons_last_place_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX seasons_last_place_id_index ON public.seasons USING btree (last_place_id);


--
-- Name: seasons_second_place_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX seasons_second_place_id_index ON public.seasons USING btree (second_place_id);


--
-- Name: seasons_third_place_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX seasons_third_place_id_index ON public.seasons USING btree (third_place_id);


--
-- Name: seasons_year_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX seasons_year_index ON public.seasons USING btree (year);


--
-- Name: teams_user_id_season_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX teams_user_id_season_id_index ON public.teams USING btree (user_id, season_id);


--
-- Name: users_espn_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_espn_id_index ON public.users USING btree (espn_id);


--
-- Name: weeks_season_id_week_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX weeks_season_id_week_index ON public.weeks USING btree (season_id, week);


--
-- Name: matchups matchups_away_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matchups
    ADD CONSTRAINT matchups_away_team_id_fkey FOREIGN KEY (away_team_id) REFERENCES public.teams(id);


--
-- Name: matchups matchups_home_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matchups
    ADD CONSTRAINT matchups_home_team_id_fkey FOREIGN KEY (home_team_id) REFERENCES public.teams(id);


--
-- Name: matchups matchups_season_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matchups
    ADD CONSTRAINT matchups_season_id_fkey FOREIGN KEY (season_id) REFERENCES public.seasons(id);


--
-- Name: matchups matchups_week_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.matchups
    ADD CONSTRAINT matchups_week_id_fkey FOREIGN KEY (week_id) REFERENCES public.weeks(id);


--
-- Name: seasons seasons_first_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_first_place_id_fkey FOREIGN KEY (first_place_id) REFERENCES public.users(id);


--
-- Name: seasons seasons_last_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_last_place_id_fkey FOREIGN KEY (last_place_id) REFERENCES public.users(id);


--
-- Name: seasons seasons_second_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_second_place_id_fkey FOREIGN KEY (second_place_id) REFERENCES public.users(id);


--
-- Name: seasons seasons_third_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_third_place_id_fkey FOREIGN KEY (third_place_id) REFERENCES public.users(id);


--
-- Name: teams teams_season_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_season_id_fkey FOREIGN KEY (season_id) REFERENCES public.seasons(id);


--
-- Name: teams teams_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: weeks weeks_season_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.weeks
    ADD CONSTRAINT weeks_season_id_fkey FOREIGN KEY (season_id) REFERENCES public.seasons(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20220916170616);
