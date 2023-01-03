--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1

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
-- Name: dimension; Type: TYPE; Schema: public; Owner: hack_api_user
--

CREATE TYPE public.dimension AS ENUM (
    'unknown',
    'c_137',
    'c_500_a',
    'post_apocalyptic_dimension',
    'replacement_dimension',
    'fantasy_dimension',
    'testicle_monster_dimension',
    'giant_telepathic_spiders_dimension',
    'pizza_dimension',
    'chair_dimension',
    'phone_dimension'
);


ALTER TYPE public.dimension OWNER TO "hack_api_user";

--
-- Name: gender; Type: TYPE; Schema: public; Owner: hack_api_user
--

CREATE TYPE public.gender AS ENUM (
    'male',
    'female',
    'unknown'
);


ALTER TYPE public.gender OWNER TO "hack_api_user";

--
-- Name: locationtype; Type: TYPE; Schema: public; Owner: hack_api_user
--

CREATE TYPE public.locationtype AS ENUM (
    'unknown',
    'planet',
    'cluster',
    'microverse',
    'teenyverse',
    'miniverse',
    'space_station',
    'tv',
    'resort',
    'fantasy_town',
    'dream',
    'menagerie',
    'game',
    'celestial_dwarf',
    'spacecraft'
);


ALTER TYPE public.locationtype OWNER TO "hack_api_user";

--
-- Name: species; Type: TYPE; Schema: public; Owner: hack_api_user
--

CREATE TYPE public.species AS ENUM (
    'human',
    'alien',
    'humanoid',
    'animal',
    'parasite',
    'cronenberg',
    'disease',
    'robot',
    'unknown',
    'mytholog',
    'vampire'
);


ALTER TYPE public.species OWNER TO "hack_api_user";

--
-- Name: status; Type: TYPE; Schema: public; Owner: hack_api_user
--

CREATE TYPE public.status AS ENUM (
    'alive',
    'dead',
    'unknown'
);


ALTER TYPE public.status OWNER TO "hack_api_user";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: adventure_participants; Type: TABLE; Schema: public; Owner: hack_api_user
--

CREATE TABLE public.adventure_participants (
    id integer NOT NULL,
    participant_id integer,
    adventure_id integer
);


ALTER TABLE public.adventure_participants OWNER TO "hack_api_user";

--
-- Name: adventure_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: hack_api_user
--

CREATE SEQUENCE public.adventure_participants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adventure_participants_id_seq OWNER TO "hack_api_user";

--
-- Name: adventure_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hack_api_user
--

ALTER SEQUENCE public.adventure_participants_id_seq OWNED BY public.adventure_participants.id;


--
-- Name: adventures; Type: TABLE; Schema: public; Owner: hack_api_user
--

CREATE TABLE public.adventures (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    location_id integer,
    started_at timestamp without time zone,
    active_till timestamp without time zone
);


ALTER TABLE public.adventures OWNER TO "hack_api_user";

--
-- Name: adventures_id_seq; Type: SEQUENCE; Schema: public; Owner: hack_api_user
--

CREATE SEQUENCE public.adventures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adventures_id_seq OWNER TO "hack_api_user";

--
-- Name: adventures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hack_api_user
--

ALTER SEQUENCE public.adventures_id_seq OWNED BY public.adventures.id;


--
-- Name: characters; Type: TABLE; Schema: public; Owner: hack_api_user
--

CREATE TABLE public.characters (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    status public.status NOT NULL,
    type character varying(255) NOT NULL,
    species public.species NOT NULL,
    gender public.gender NOT NULL,
    image_url text,
    created_at timestamp without time zone,
    origin_location_id integer,
    current_location_id integer
);


ALTER TABLE public.characters OWNER TO "hack_api_user";

--
-- Name: characters_id_seq; Type: SEQUENCE; Schema: public; Owner: hack_api_user
--

CREATE SEQUENCE public.characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.characters_id_seq OWNER TO "hack_api_user";

--
-- Name: characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hack_api_user
--

ALTER SEQUENCE public.characters_id_seq OWNED BY public.characters.id;


--
-- Name: episode_characters; Type: TABLE; Schema: public; Owner: hack_api_user
--

CREATE TABLE public.episode_characters (
    id integer NOT NULL,
    character_id integer,
    episode_id integer
);


ALTER TABLE public.episode_characters OWNER TO "hack_api_user";

--
-- Name: episode_characters_id_seq; Type: SEQUENCE; Schema: public; Owner: hack_api_user
--

CREATE SEQUENCE public.episode_characters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.episode_characters_id_seq OWNER TO "hack_api_user";

--
-- Name: episode_characters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hack_api_user
--

ALTER SEQUENCE public.episode_characters_id_seq OWNED BY public.episode_characters.id;


--
-- Name: episodes; Type: TABLE; Schema: public; Owner: hack_api_user
--

CREATE TABLE public.episodes (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    air_date date,
    season integer,
    episode_number integer
);


ALTER TABLE public.episodes OWNER TO "hack_api_user";

--
-- Name: episodes_id_seq; Type: SEQUENCE; Schema: public; Owner: hack_api_user
--

CREATE SEQUENCE public.episodes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.episodes_id_seq OWNER TO "hack_api_user";

--
-- Name: episodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hack_api_user
--

ALTER SEQUENCE public.episodes_id_seq OWNED BY public.episodes.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: hack_api_user
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    dimension public.dimension NOT NULL,
    created_at timestamp without time zone,
    type public.locationtype NOT NULL
);


ALTER TABLE public.locations OWNER TO "hack_api_user";

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: hack_api_user
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO "hack_api_user";

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: hack_api_user
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: adventure_participants id; Type: DEFAULT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.adventure_participants ALTER COLUMN id SET DEFAULT nextval('public.adventure_participants_id_seq'::regclass);


--
-- Name: adventures id; Type: DEFAULT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.adventures ALTER COLUMN id SET DEFAULT nextval('public.adventures_id_seq'::regclass);


--
-- Name: characters id; Type: DEFAULT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.characters ALTER COLUMN id SET DEFAULT nextval('public.characters_id_seq'::regclass);


--
-- Name: episode_characters id; Type: DEFAULT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.episode_characters ALTER COLUMN id SET DEFAULT nextval('public.episode_characters_id_seq'::regclass);


--
-- Name: episodes id; Type: DEFAULT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.episodes ALTER COLUMN id SET DEFAULT nextval('public.episodes_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Data for Name: adventure_participants; Type: TABLE DATA; Schema: public; Owner: hack_api_user
--

COPY public.adventure_participants (id, participant_id, adventure_id) FROM stdin;
\.


--
-- Data for Name: adventures; Type: TABLE DATA; Schema: public; Owner: hack_api_user
--

COPY public.adventures (id, name, location_id, started_at, active_till) FROM stdin;
\.


--
-- Data for Name: characters; Type: TABLE DATA; Schema: public; Owner: hack_api_user
--

COPY public.characters (id, name, status, type, species, gender, image_url, created_at, origin_location_id, current_location_id) FROM stdin;
452	Simon	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/3/35/Screenshot_2015-09-29_at_11.20.50_AM.png	2022-11-27 09:15:43.997063	20	20
473	Bartender Morty	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/9/92/S3e7_nother_bartender_morty.png	2022-11-27 09:15:43.997799	\N	3
476	Flower Morty	alive	Human with a flower in his head	human	male	https://static.wikia.nocookie.net/rickandmorty/images/6/69/FlowerHeadMorty.png	2022-11-27 09:15:43.997816	\N	3
487	Visor Rick	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/6/6a/Visor_Rick_Citadel.png	2022-11-27 09:15:43.997879	\N	3
490	Chang	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/6/61/S3e8_2019-12-14-22h21m39s844.png	2022-11-27 09:15:43.997896	\N	25
492	Varrix	alive		alien	unknown	https://static.wikia.nocookie.net/rickandmorty/images/4/47/S3e9_Varrix_nesting.png	2022-11-27 09:15:43.997907	\N	20
479	Private Sector Rick	dead		human	male	\N	2022-11-27 09:15:43.997833	\N	3
480	Purple Morty	alive		alien	male	\N	2022-11-27 09:15:43.997839	\N	3
13	Alien Googah	unknown		alien	unknown	\N	2022-11-27 09:15:43.989412	\N	20
481	Retired General Rick	unknown		human	male	\N	2022-11-27 09:15:43.997845	\N	3
3	Summer Smith	alive		human	female	\N	2022-11-27 09:15:43.989221	20	20
23	Arcade Alien	unknown		alien	male	\N	2022-11-27 09:15:43.989586	\N	7
35	Bepisian	alive	Bepisian	alien	unknown	\N	2022-11-27 09:15:43.989808	11	11
37	Beth Sanchez	alive		human	female	\N	2022-11-27 09:15:43.989842	23	23
44	Body Guard Morty	dead		human	male	\N	2022-11-27 09:15:43.989963	\N	3
49	Blamph	alive		alien	unknown	\N	2022-11-27 09:15:43.990049	\N	6
55	Boobloosian	dead	Boobloosian	alien	unknown	\N	2022-11-27 09:15:43.99015	\N	13
57	Borpocian	alive	Elephant-Person	alien	male	\N	2022-11-27 09:15:43.990184	\N	1
66	Coach Feratu (Balik Alistane)	dead		vampire	male	\N	2022-11-27 09:15:43.990338	20	20
104	Doom-Nomitron	dead	Shapeshifter	alien	unknown	\N	2022-11-27 09:15:43.99099	\N	29
114	Ethan	unknown	Cronenberg	human	male	\N	2022-11-27 09:15:43.991168	1	1
47	Birdperson	dead	Bird-Person	alien	male	\N	2022-11-27 09:15:43.990015	1	35
52	Blue Footprint Guy	dead		human	male	\N	2022-11-27 09:15:43.9901	8	8
53	Blue Shirt Morty	unknown		human	male	\N	2022-11-27 09:15:43.990117	\N	3
56	Bootleg Portal Chemist Rick	dead		human	male	\N	2022-11-27 09:15:43.990167	\N	3
58	Brad	alive		human	male	\N	2022-11-27 09:15:43.990201	20	20
96	Tuberculosis	dead		disease	unknown	\N	2022-11-27 09:15:43.990849	5	5
97	Gonorrhea	dead		disease	unknown	\N	2022-11-27 09:15:43.990866	5	5
98	Hepatitis A	dead		disease	unknown	\N	2022-11-27 09:15:43.990883	5	5
99	Hepatitis C	dead		disease	unknown	\N	2022-11-27 09:15:43.9909	5	5
100	Bubonic Plague	dead		disease	unknown	\N	2022-11-27 09:15:43.990921	5	5
101	E. Coli	dead		disease	unknown	\N	2022-11-27 09:15:43.990939	5	5
62	Canklanker Thom	dead	Gromflomite	alien	male	\N	2022-11-27 09:15:43.990267	1	1
77	Cowboy Morty	alive		human	male	\N	2022-11-27 09:15:43.990525	\N	3
78	Cowboy Rick	alive		human	male	\N	2022-11-27 09:15:43.990544	\N	3
109	Duck With Muscles	dead	Alien	parasite	male	\N	2022-11-27 09:15:43.991076	\N	20
94	Diane Sanchez	unknown		human	female	\N	2022-11-27 09:15:43.990815	30	30
95	Dipper and Mabel Mortys	unknown		human	unknown	\N	2022-11-27 09:15:43.990832	\N	3
108	Dr. Xenon Bloom	dead	Amoeba-Person	humanoid	male	\N	2022-11-27 09:15:43.991059	\N	5
113	Eric Stoltz Mask Morty	unknown		human	male	\N	2022-11-27 09:15:43.991151	1	20
115	Ethan	alive		human	male	\N	2022-11-27 09:15:43.991184	20	20
122	Fart	dead	Interdimensional gaseous being	alien	male	\N	2022-11-27 09:15:43.991301	\N	1
127	Frank Palicky	dead		human	male	\N	2022-11-27 09:15:43.991386	1	1
134	Garmanarnar	alive		alien	male	\N	2022-11-27 09:15:43.991504	\N	6
135	Garment District Rick	dead		human	male	\N	2022-11-27 09:15:43.991521	\N	3
137	Gene	alive		human	male	\N	2022-11-27 09:15:43.991555	20	20
142	Gibble Snake	dead	Animal	alien	unknown	\N	2022-11-27 09:15:43.991639	37	37
144	Glenn	dead	Gromflomite	alien	male	\N	2022-11-27 09:15:43.991672	\N	38
145	Glenn	alive	Eat shiter-Person	human	male	\N	2022-11-27 09:15:43.991688	\N	6
148	Goddess Beth	unknown		mytholog	female	\N	2022-11-27 09:15:43.991739	13	13
125	Flansian	alive	Flansian	alien	unknown	\N	2022-11-27 09:15:43.991353	\N	35
162	Ice-T	alive	Alphabetrian	alien	male	\N	2022-11-27 09:15:43.992037	43	43
181	Jessica's Friend	alive		human	female	\N	2022-11-27 09:15:43.992358	1	20
189	Katarina	dead		human	female	\N	2022-11-27 09:15:43.992496	20	20
205	Little Dipper	alive	Tinymouth	humanoid	male	\N	2022-11-27 09:15:43.99277	\N	6
206	Lizard Morty	alive	Lizard-Person	humanoid	male	\N	2022-11-27 09:15:43.992787	\N	3
208	Logic	alive		human	male	\N	2022-11-27 09:15:43.99282	\N	4
209	Long Sleeved Morty	unknown		human	male	\N	2022-11-27 09:15:43.992837	\N	3
133	Garblovian	alive	Garblovian	alien	male	\N	2022-11-27 09:15:43.991488	1	1
210	Lucy	dead		human	female	\N	2022-11-27 09:15:43.992853	20	20
211	Ma-Sha	alive	Gazorpian	alien	female	\N	2022-11-27 09:15:43.99287	40	40
223	Michael Jenkins	dead		human	male	\N	2022-11-27 09:15:43.993072	\N	6
230	Morty Jr.	alive	Human Gazorpian	humanoid	male	\N	2022-11-27 09:15:43.993235	20	20
231	Morty Rick	unknown		human	male	\N	2022-11-27 09:15:43.993251	\N	3
249	Mrs. Sanchez	unknown		human	female	\N	2022-11-27 09:15:43.993559	\N	1
260	Phillip Jacobs	alive		human	male	\N	2022-11-27 09:15:43.993745	\N	6
262	Photography Raptor	dead	Parasite, Dinosaur	alien	unknown	\N	2022-11-27 09:15:43.993779	\N	20
265	Pickle Rick	alive	Pickle	unknown	male	\N	2022-11-27 09:15:43.993829	1	20
266	Piece of Toast	alive	Bread	unknown	unknown	\N	2022-11-27 09:15:43.993847	\N	6
281	Reverse Rick Outrage	dead		human	male	\N	2022-11-27 09:15:43.994108	\N	3
302	Ruben	dead		human	male	\N	2022-11-27 09:15:43.994469	1	1
307	Scroopy Noopers	alive	Plutonian	alien	male	\N	2022-11-27 09:15:43.994553	47	47
308	Scropon	unknown	Lobster-Alien	alien	male	\N	2022-11-27 09:15:43.99457	\N	35
385	Yellow Shirt Rick	unknown		human	male	\N	2022-11-27 09:15:43.996178	\N	3
327	Slow Mobius	alive		humanoid	male	\N	2022-11-27 09:15:43.995179	\N	20
333	Stair Goblin	alive	Stair goblin	alien	unknown	\N	2022-11-27 09:15:43.995293	\N	48
334	Stealy	alive		unknown	male	\N	2022-11-27 09:15:43.99531	\N	6
337	Stu	dead	Zigerion	alien	male	\N	2022-11-27 09:15:43.995359	\N	46
153	Hamster In Butt	alive		animal	unknown	\N	2022-11-27 09:15:43.991829	41	41
338	Summer Smith	alive		human	female	\N	2022-11-27 09:15:43.995376	1	1
339	Summer Smith	alive		human	female	\N	2022-11-27 09:15:43.995393	34	34
343	Tammy Guetermann	alive		cronenberg	male	\N	2022-11-27 09:15:43.99546	1	1
344	Tammy Guetermann	alive		human	female	\N	2022-11-27 09:15:43.995477	20	1
375	Vance Maximus	dead		human	male	\N	2022-11-27 09:15:43.996013	\N	4
377	Voltematron	dead	Parasite	alien	unknown	\N	2022-11-27 09:15:43.996046	\N	20
166	Invisi-trooper	alive		human	male	\N	2022-11-27 09:15:43.992105	20	20
174	Jerry 5-126	alive		human	male	\N	2022-11-27 09:15:43.992239	1	44
176	Celebrity Jerry	alive		human	male	\N	2022-11-27 09:15:43.992273	23	23
102	Donna Gueterman	dead		robot	female	https://static.wikia.nocookie.net/rickandmorty/images/0/0b/Donna_Picture.png	2022-11-27 09:15:43.990956	\N	35
103	Doofus Rick	unknown		human	male	https://static.wikia.nocookie.net/rickandmorty/images/d/dd/S1e10_doofy.png	2022-11-27 09:15:43.990973	1	20
105	Dr. Glip-Glop	dead		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/2/26/Drglipglop.png	2022-11-27 09:15:43.991007	\N	16
185	Joseph Eli Lipkip	alive		human	male	\N	2022-11-27 09:15:43.992425	20	20
194	Kozbian	alive	Tentacle alien	alien	unknown	\N	2022-11-27 09:15:43.992581	\N	35
199	Larva Alien	alive	Larva alien	alien	unknown	\N	2022-11-27 09:15:43.992665	1	35
212	Magma-Q	dead	Alphabetrian	alien	male	\N	2022-11-27 09:15:43.992887	43	43
222	Michael Denny and the Denny Singers	alive		human	male	\N	2022-11-27 09:15:43.993055	\N	6
228	Mohawk Guy	dead		human	male	\N	2022-11-27 09:15:43.993201	8	8
233	Morty K-22	alive		human	male	\N	2022-11-27 09:15:43.993285	1	20
235	Mortytown Loco	dead		human	male	\N	2022-11-27 09:15:43.993318	\N	3
253	Numbericon	unknown	Numbericon	alien	unknown	\N	2022-11-27 09:15:43.993627	\N	43
255	Orthodox Jew	alive		human	male	\N	2022-11-27 09:15:43.993661	20	20
261	Photography Cyborg	unknown		robot	male	\N	2022-11-27 09:15:43.993762	\N	35
263	Pibbles Bodyguard	alive	Hairy alien	alien	male	\N	2022-11-27 09:15:43.993795	\N	16
286	Rick D-99	dead		human	male	\N	2022-11-27 09:15:43.994191	1	3
287	Rick D716	dead		human	male	\N	2022-11-27 09:15:43.994207	1	3
288	Rick D716-B	alive		human	male	\N	2022-11-27 09:15:43.994228	1	3
289	Rick D716-C	alive		human	male	\N	2022-11-27 09:15:43.994245	1	3
292	Rick K-22	alive		human	male	\N	2022-11-27 09:15:43.994295	1	20
309	Scrotian	alive	Scrotian	animal	male	\N	2022-11-27 09:15:43.994587	\N	22
311	Shimshamian	alive	Shimshamian	alien	male	\N	2022-11-27 09:15:43.994621	\N	35
329	Snuffles (Snowball)	alive	Intelligent dog	animal	male	\N	2022-11-27 09:15:43.995213	1	1
387	Zarbadar's Mytholog	unknown		mytholog	female	https://static.wikia.nocookie.net/rickandmorty/images/c/c2/Screenshot_2016-11-04_at_11.07.48_PM.png	2022-11-27 09:15:43.996212	13	13
388	Zeep Xanflorp	alive	Microverse inhabitant	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/1/16/Zeep.png	2022-11-27 09:15:43.996229	24	24
389	Zeta Alpha Rick	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/9/91/ZetaAlphaRickS3.png	2022-11-27 09:15:43.996245	\N	3
390	Zick Zack	dead	Floop Floopian	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/0/00/Rm.s03e08.s08.png	2022-11-27 09:15:43.996262	\N	20
391	Uncle Steve	dead	Parasite	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/5/50/UncleSteve.png	2022-11-27 09:15:43.996278	\N	20
394	Davin	dead		cronenberg	male	https://static.wikia.nocookie.net/rickandmorty/images/f/f9/Davin2.png	2022-11-27 09:15:43.996339	1	1
409	Mr. Sneezy	alive	Little Human	human	male	https://static.wikia.nocookie.net/rickandmorty/images/5/5e/Mr._Sneexy.png	2022-11-27 09:15:43.996598	6	6
359	Tortured Morty	unknown		human	male	\N	2022-11-27 09:15:43.995739	\N	3
393	Roy	alive	Game	human	male	\N	2022-11-27 09:15:43.996321	32	32
362	Traflorkian	alive	Traflorkian	alien	unknown	\N	2022-11-27 09:15:43.995789	\N	4
434	Super Weird Rick	unknown		human	male	\N	2022-11-27 09:15:43.996951	\N	1
364	Tree Person	dead	Teenyverse inhabitant	humanoid	unknown	\N	2022-11-27 09:15:43.995823	50	50
374	Vampire Master	alive		vampire	male	\N	2022-11-27 09:15:43.995996	20	20
367	Trunk Man	alive	Trunk-Person	humanoid	male	\N	2022-11-27 09:15:43.995873	1	6
371	Tumblorkian	alive	Tumblorkian	alien	male	\N	2022-11-27 09:15:43.99594	66	66
373	Unmuscular Michael	alive		human	male	\N	2022-11-27 09:15:43.995979	\N	6
378	Wall Crawling Rick	unknown	Lizard-Person	humanoid	male	\N	2022-11-27 09:15:43.996063	\N	3
381	Woman Rick	alive	Chair	alien	female	\N	2022-11-27 09:15:43.996112	\N	1
384	Yellow Headed Doctor	alive		alien	male	\N	2022-11-27 09:15:43.996162	\N	16
392	Bearded Morty	alive		human	male	\N	2022-11-27 09:15:43.996295	\N	3
395	Greebybobe	alive	Greebybobe	alien	unknown	\N	2022-11-27 09:15:43.996356	1	4
396	Scary Teacher	alive	Monster	humanoid	male	\N	2022-11-27 09:15:43.996373	18	18
397	Fido	alive	Dog	animal	male	\N	2022-11-27 09:15:43.99639	70	70
398	Accountant dog	alive	Dog	animal	male	\N	2022-11-27 09:15:43.996407	70	70
399	Tiny-persons advocacy group lawyer	alive	Giant	humanoid	male	\N	2022-11-27 09:15:43.996424	14	14
400	Giant Judge	alive	Giant	humanoid	male	\N	2022-11-27 09:15:43.996442	14	14
401	Morty Jr's interviewer	alive		human	male	\N	2022-11-27 09:15:43.996458	20	20
402	Guy from The Bachelor	alive		human	male	\N	2022-11-27 09:15:43.996475	20	20
403	Corn detective	dead	Corn-person	humanoid	male	\N	2022-11-27 09:15:43.996496	6	6
404	Michael Jackson	alive	Phone-Person	humanoid	male	\N	2022-11-27 09:15:43.996514	72	72
405	Trunkphobic suspenders guy	alive		human	male	\N	2022-11-27 09:15:43.996531	\N	20
406	Spiderweb teddy bear	alive	Teddy Bear	animal	unknown	\N	2022-11-27 09:15:43.996548	6	6
407	Regular Tyrion Lannister	alive		human	male	\N	2022-11-27 09:15:43.996564	6	6
408	Quick Mistery Presenter	alive		human	male	\N	2022-11-27 09:15:43.996581	6	6
410	Two Brothers	alive		human	male	\N	2022-11-27 09:15:43.996615	6	6
411	Alien Mexican Armada	unknown	Mexican	alien	male	\N	2022-11-27 09:15:43.996631	6	6
412	Giant Cat Monster	unknown	Giant Cat Monster	animal	unknown	\N	2022-11-27 09:15:43.996652	6	6
413	Old Women	unknown	Old Amazons	human	female	\N	2022-11-27 09:15:43.99667	6	6
414	Trunkphobic guy	alive		human	male	\N	2022-11-27 09:15:43.996687	6	6
415	Pro trunk people marriage guy	alive		human	male	\N	2022-11-27 09:15:43.996707	6	6
416	Muscular Mannie	alive	Mannie	human	male	\N	2022-11-27 09:15:43.996788	6	6
417	Baby Legs Chief	alive		human	male	\N	2022-11-27 09:15:43.996829	6	6
418	Mrs. Sullivan's Boyfriend	alive	Necrophiliac	human	male	\N	2022-11-27 09:15:43.996837	6	6
419	Plutonian Hostess	alive	Plutonian	alien	female	\N	2022-11-27 09:15:43.996844	47	47
420	Plutonian Host	alive	Plutonian	alien	male	\N	2022-11-27 09:15:43.996851	47	47
421	Rich Plutonian	alive	Plutonian	alien	female	\N	2022-11-27 09:15:43.996857	47	47
422	Rich Plutonian	alive	Plutonian	alien	male	\N	2022-11-27 09:15:43.996864	47	47
423	Synthetic Laser Eels	alive	Eel	animal	unknown	\N	2022-11-27 09:15:43.996879	20	20
424	Pizza-person	alive	Pizza	humanoid	male	\N	2022-11-27 09:15:43.996889	71	71
425	Pizza-person	alive	Pizza	humanoid	male	\N	2022-11-27 09:15:43.996895	71	71
426	Greasy Grandma	alive	Grandma	human	female	\N	2022-11-27 09:15:43.996901	73	73
427	Phone-person	alive	Phone	humanoid	male	\N	2022-11-27 09:15:43.996907	72	72
428	Phone-person	alive	Phone	humanoid	male	\N	2022-11-27 09:15:43.996913	72	72
429	Chair-person	alive	Chair	humanoid	male	\N	2022-11-27 09:15:43.996919	74	74
430	Chair-person	alive	Chair	humanoid	male	\N	2022-11-27 09:15:43.996925	74	74
431	Chair-homeless	alive	Chair	humanoid	male	\N	2022-11-27 09:15:43.996931	74	74
432	Chair-waiter	alive	Chair	humanoid	male	\N	2022-11-27 09:15:43.996938	74	74
433	Doopidoo	alive	Doopidoo	animal	unknown	\N	2022-11-27 09:15:43.996944	\N	1
435	Pripudlian	alive	Pripudlian	alien	unknown	\N	2022-11-27 09:15:43.996957	\N	20
436	Giant Testicle Monster	alive	Monster	animal	unknown	\N	2022-11-27 09:15:43.996964	21	21
437	Michael	alive		human	male	\N	2022-11-27 09:15:43.996971	20	20
438	Michael's Lawyer	alive		human	male	\N	2022-11-27 09:15:43.996977	20	20
439	Veterinary	alive		human	female	\N	2022-11-27 09:15:43.996983	20	20
440	Veterinary Nurse	alive		human	male	\N	2022-11-27 09:15:43.996989	20	20
441	Bearded Jerry	alive		human	male	\N	2022-11-27 09:15:43.996995	\N	44
442	Shaved Head Jerry	alive		human	male	\N	2022-11-27 09:15:43.997001	\N	44
443	Tank Top Jerry	alive		human	male	\N	2022-11-27 09:15:43.997008	\N	44
444	Pink Polo Shirt Jerry	alive		human	male	\N	2022-11-27 09:15:43.997014	\N	44
445	Jerryboree Keeper	alive		alien	female	\N	2022-11-27 09:15:43.99702	\N	44
446	Jerryboree Receptionist	alive		alien	male	\N	2022-11-27 09:15:43.997026	\N	44
447	Anchor Gear	alive	Gear-Person	alien	male	\N	2022-11-27 09:15:43.997033	57	57
448	Gear Cop	dead	Gear-Person	alien	male	\N	2022-11-27 09:15:43.997039	57	57
449	Roy's Mum	alive	Game	human	female	\N	2022-11-27 09:15:43.997045	32	32
450	Roy's Wife	alive	Game	human	male	\N	2022-11-27 09:15:43.997051	32	32
451	Roy's Son	alive	Game	human	male	\N	2022-11-27 09:15:43.997057	32	32
453	Vampire Master's Assistant	alive		vampire	male	\N	2022-11-27 09:15:43.997069	\N	20
454	Arbolian Mentirososian	alive		alien	unknown	\N	2022-11-27 09:15:43.997075	1	16
455	St. Gloopy Noops Nurse	alive		alien	female	\N	2022-11-27 09:15:43.997082	\N	16
456	Nano Doctor	alive	Nano Alien	alien	male	\N	2022-11-27 09:15:43.997089	\N	16
457	Funny Songs Presenter	alive		human	male	\N	2022-11-27 09:15:43.997676	\N	6
458	Tax Attorney	unknown		human	male	\N	2022-11-27 09:15:43.997684	\N	6
459	Butthole Ice Cream Guy	alive		alien	male	\N	2022-11-27 09:15:43.99769	\N	6
460	Traflorkian Journalist	alive	Traflorkian	alien	male	\N	2022-11-27 09:15:43.997696	\N	16
461	Communication's Responsible Rick	dead		human	male	\N	2022-11-27 09:15:43.997702	\N	3
462	Teleportation's Responsible Rick	unknown		human	male	\N	2022-11-27 09:15:43.997708	\N	3
463	SEAL Team Rick	dead		human	male	\N	2022-11-27 09:15:43.997714	\N	3
464	SEAL Team Rick	dead		human	male	\N	2022-11-27 09:15:43.99772	\N	3
465	SEAL Team Rick	dead		human	male	\N	2022-11-27 09:15:43.997726	\N	3
466	SEAL Team Rick	dead		human	male	\N	2022-11-27 09:15:43.997756	\N	3
467	Morphizer-XE Customer Support	alive		alien	male	\N	2022-11-27 09:15:43.997762	\N	20
468	Morphizer-XE Customer Support	alive		alien	male	\N	2022-11-27 09:15:43.997768	\N	20
469	Morphizer-XE Customer Support	unknown		alien	male	\N	2022-11-27 09:15:43.997774	\N	20
470	Alien Spa Employee	alive		alien	male	\N	2022-11-27 09:15:43.99778	\N	76
471	Little Voltron	alive		robot	unknown	\N	2022-11-27 09:15:43.997788	\N	20
472	Baby Rick	alive	Clone	human	male	\N	2022-11-27 09:15:43.997793	3	3
474	Dancer Cowboy Morty	alive		human	male	\N	2022-11-27 09:15:43.997805	\N	3
475	Dancer Morty	alive		human	male	\N	2022-11-27 09:15:43.99781	\N	3
477	Hairdresser Rick	alive		human	male	\N	2022-11-27 09:15:43.997822	\N	3
478	Journalist Rick	alive		human	male	\N	2022-11-27 09:15:43.997828	\N	3
482	Secret Service Rick	alive		human	male	\N	2022-11-27 09:15:43.997851	\N	3
483	Steve Jobs Rick	alive		human	male	\N	2022-11-27 09:15:43.997856	\N	3
484	Sheik Rick	dead		human	male	\N	2022-11-27 09:15:43.997862	\N	3
485	Modern Rick	alive		human	male	\N	2022-11-27 09:15:43.997868	\N	3
486	Tan Rick	dead		human	male	\N	2022-11-27 09:15:43.997873	\N	3
488	Colonial Rick	dead		human	male	\N	2022-11-27 09:15:43.997885	\N	3
489	P-Coat Rick	dead		human	male	\N	2022-11-27 09:15:43.99789	\N	3
491	Dr. Eleanor Arroway	alive		human	female	\N	2022-11-27 09:15:43.997901	\N	25
493	Secretary of the Interior	alive		human	male	\N	2022-11-27 09:15:43.997913	20	20
1	Rick Sanchez	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a6/Rick_Sanchez.png	2022-11-27 09:15:43.989142	1	20
2	Morty Smith	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/e/ee/Morty501.png	2022-11-27 09:15:43.989195	1	20
4	Beth Smith	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/5/58/Beth_Smith.png	2022-11-27 09:15:43.989242	20	20
5	Jerry Smith	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/f/f1/Jerry_Smith.png	2022-11-27 09:15:43.989261	20	20
6	Abadango Cluster Princess	alive		alien	female	https://static.wikia.nocookie.net/rickandmorty/images/7/7e/Cluster_Princess.png	2022-11-27 09:15:43.98928	2	2
7	Abradolf Lincler	unknown	Genetic experiment	human	male	https://static.wikia.nocookie.net/rickandmorty/images/b/bb/Abradolf_Lincler_Angry.png	2022-11-27 09:15:43.989299	20	21
9	Agency Director	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/4c/S3e3_leader.png	2022-11-27 09:15:43.989341	20	20
10	Alan Rails	dead	Superhuman (Ghost trains summoner)	human	male	https://static.wikia.nocookie.net/rickandmorty/images/6/6a/AlanRails.png	2022-11-27 09:15:43.98936	\N	4
11	Albert Einstein	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/b/bc/Albert_Einstein.png	2022-11-27 09:15:43.989378	1	20
12	Alexander	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/f/fe/Screenshot_2015-10-01_at_7.56.29_AM.png	2022-11-27 09:15:43.989395	1	5
14	Alien Morty	unknown		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/c/c8/Alien_Morty.png	2022-11-27 09:15:43.989429	\N	3
15	Alien Rick	unknown		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/6/6c/Alien_Rick.png	2022-11-27 09:15:43.989446	\N	3
16	Amish Cyborg	dead	Parasite, Cyborg	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a6/Amish_Cyborg.png	2022-11-27 09:15:43.989463	\N	20
17	Annie	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/0/01/Annie.png	2022-11-27 09:15:43.989481	1	5
18	Antenna Morty	alive	Human with antennae	human	male	https://static.wikia.nocookie.net/rickandmorty/images/6/6e/Antenna_Morty.png	2022-11-27 09:15:43.989498	\N	3
8	Adjudicator Rick	dead		human	male	\N	2022-11-27 09:15:43.989322	\N	3
19	Antenna Rick	unknown	Human with antennae	human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/49/Antenna_Rick.png	2022-11-27 09:15:43.989515	\N	1
20	Ants in my Eyes Johnson	unknown	Human with ants in his eyes	human	male	https://static.wikia.nocookie.net/rickandmorty/images/2/28/Ants_in_my_eyes_johnson.png	2022-11-27 09:15:43.989532	\N	6
21	Aqua Morty	unknown	Fish-Person	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/c/c2/Fish_Morty.png	2022-11-27 09:15:43.98955	\N	3
22	Aqua Rick	unknown	Fish-Person	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/8/83/Fish_Rick.png	2022-11-27 09:15:43.989568	\N	3
24	Armagheadon	alive	Cromulon	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/7/72/S2e5_Cromulon.png	2022-11-27 09:15:43.989603	22	22
25	Armothy	dead	Self-aware arm	unknown	male	https://static.wikia.nocookie.net/rickandmorty/images/6/66/Armothy.png	2022-11-27 09:15:43.98962	8	8
26	Arthricia	alive	Cat-Person	alien	female	https://static.wikia.nocookie.net/rickandmorty/images/3/31/Arthricia_end_HQ.png	2022-11-27 09:15:43.989638	9	9
27	Artist Morty	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/d/dc/Artsy.png	2022-11-27 09:15:43.989655	\N	3
28	Attila Starwar	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/7/70/Attila.transparent.png	2022-11-27 09:15:43.989671	\N	6
29	Baby Legs	alive	Human with baby legs	human	male	https://static.wikia.nocookie.net/rickandmorty/images/c/cd/Baby_Legs.png	2022-11-27 09:15:43.989697	\N	6
30	Baby Poopybutthole	alive		unknown	male	https://static.wikia.nocookie.net/rickandmorty/images/9/9b/Baby_Poopybutthole.png	2022-11-27 09:15:43.989716	\N	1
31	Baby Wizard	dead	Parasite	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/d/da/BabyWizard.png	2022-11-27 09:15:43.989733	\N	20
32	Bearded Lady	dead	Parasite	alien	female	https://static.wikia.nocookie.net/rickandmorty/images/0/06/Bearded_Lady.png	2022-11-27 09:15:43.989751	\N	20
33	Beebo	dead		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/9/96/Beebo.png	2022-11-27 09:15:43.989772	10	10
34	Benjamin	alive		unknown	male	https://static.wikia.nocookie.net/rickandmorty/images/3/3d/Screenshot_2016-11-16_at_5.44.20_PM.png	2022-11-27 09:15:43.98979	\N	6
36	Beta-Seven	alive	Hivemind	alien	unknown	https://static.wikia.nocookie.net/rickandmorty/images/b/b0/Beta-Seven.png	2022-11-27 09:15:43.989825	\N	1
38	Beth Smith	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/5/58/Beth_Smith.png	2022-11-27 09:15:43.989859	1	1
39	Beth Smith	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/5/58/Beth_Smith.png	2022-11-27 09:15:43.989877	34	34
40	Beth's Mytholog	dead		mytholog	female	https://static.wikia.nocookie.net/rickandmorty/images/8/8e/Screenshot_2015-09-14_at_2.13.24_PM.png	2022-11-27 09:15:43.989894	13	13
41	Big Boobed Waitress	alive		humanoid	female	https://static.wikia.nocookie.net/rickandmorty/images/c/c8/Waitress_Lady.png	2022-11-27 09:15:43.989912	48	48
42	Big Head Morty	unknown	Human with giant head	human	male	https://static.wikia.nocookie.net/rickandmorty/images/0/0c/Citadel_Morty_Big_Head.png	2022-11-27 09:15:43.989929	\N	3
43	Big Morty	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/8/84/BigMorty.png	2022-11-27 09:15:43.989946	\N	3
45	Bill	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/0/0b/BillNewsPresenter.png	2022-11-27 09:15:43.98998	1	1
46	Bill	unknown	Dog	animal	male	https://static.wikia.nocookie.net/rickandmorty/images/0/0b/BillNewsPresenter.png	2022-11-27 09:15:43.989998	20	1
48	Black Rick	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/4c/Screen_Shot_2017-12-29_at_4.48.33_PM.png	2022-11-27 09:15:43.990032	\N	3
50	Blim Blam	alive	Korblock	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/e/ec/Blim_Blam.png	2022-11-27 09:15:43.990066	\N	20
51	Blue Diplomat	alive		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/a/ad/S2e8_peaceful_diplomat.png	2022-11-27 09:15:43.990083	\N	6
54	Bobby Moynihan	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/e/e9/Bobbymoynihan.png	2022-11-27 09:15:43.990134	\N	6
59	Brad Anderson	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/d/d1/Brad_Anderson_2.png	2022-11-27 09:15:43.990218	20	20
60	Calypso	dead	Superhuman	human	female	https://static.wikia.nocookie.net/rickandmorty/images/f/fa/CalypsoVindicators2.png	2022-11-27 09:15:43.990234	\N	1
61	Campaign Manager Morty	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/44/Campaignmorty.png	2022-11-27 09:15:43.99025	\N	3
63	Centaur	alive	Centaur	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/b/bc/Centaur.png	2022-11-27 09:15:43.990284	\N	18
64	Chris	dead	Organic gun	alien	unknown	https://static.wikia.nocookie.net/rickandmorty/images/e/ea/Rick_and_Morty_Chris.png	2022-11-27 09:15:43.990301	\N	20
65	Chris	alive	Microverse inhabitant	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/e/ea/Rick_and_Morty_Chris.png	2022-11-27 09:15:43.990319	24	24
67	Collector	alive	Light bulb-Alien	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/8/8e/S3e8_the_menagerie.png	2022-11-27 09:15:43.990355	25	25
68	Colossus	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/c/cb/Summer%27s_Victim.png	2022-11-27 09:15:43.990372	8	8
69	Commander Rick	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/4e/Commander_in_Chief_Rick.png	2022-11-27 09:15:43.990389	\N	3
70	Concerto	dead		humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/8/89/Concerto1.png	2022-11-27 09:15:43.990406	\N	1
71	Conroy	dead		robot	unknown	https://static.wikia.nocookie.net/rickandmorty/images/a/ab/Conroy.png	2022-11-27 09:15:43.990423	20	1
72	Cool Rick	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/0/04/Cool_Rick.png	2022-11-27 09:15:43.99044	1	3
73	Cop Morty	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/6/6d/CopMorty.png	2022-11-27 09:15:43.990456	\N	3
74	Cop Rick	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/b/b4/Coprick50.png	2022-11-27 09:15:43.990473	\N	3
75	Courier Flap	alive		alien	unknown	https://static.wikia.nocookie.net/rickandmorty/images/9/9e/CourierFlap.png	2022-11-27 09:15:43.990491	\N	35
76	Cousin Nicky	dead	Parasite	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/f/fa/Cousin_Nicky.png	2022-11-27 09:15:43.990508	\N	20
79	Crab Spider	alive	Animal	alien	unknown	https://static.wikia.nocookie.net/rickandmorty/images/3/35/CrabSurroundRick.png	2022-11-27 09:15:43.990561	27	27
80	Creepy Little Girl	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/a/ad/Scary_Little_Girl.png	2022-11-27 09:15:43.990578	\N	18
81	Crocubot	dead	Robot-Crocodile hybrid	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/6/68/Crocubot.png	2022-11-27 09:15:43.990595	\N	4
82	Cronenberg Rick	unknown		cronenberg	male	https://static.wikia.nocookie.net/rickandmorty/images/7/70/Cronenberg_Rick.png	2022-11-27 09:15:43.990613	1	1
83	Cronenberg Morty	unknown		cronenberg	male	https://static.wikia.nocookie.net/rickandmorty/images/c/c5/Cronenberg_Morty.png	2022-11-27 09:15:43.99063	1	1
84	Cult Leader Morty	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/9/9f/Screenshot_2016-11-16_at_8.45.25_PM.png	2022-11-27 09:15:43.990646	\N	27
85	Cyclops Morty	alive		humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/8/8f/Cyclops_Morty.png	2022-11-27 09:15:43.990663	\N	3
86	Cyclops Rick	dead		humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/b/b3/Cyclops_Rick.png	2022-11-27 09:15:43.99068	\N	3
87	Cynthia	dead	Zigerion	alien	female	https://static.wikia.nocookie.net/rickandmorty/images/8/8f/Screenshot_2015-09-28_at_7.13.15_PM.png	2022-11-27 09:15:43.990696	\N	46
88	Cynthia	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/8/8f/Screenshot_2015-09-28_at_7.13.15_PM.png	2022-11-27 09:15:43.990714	20	20
89	Dale	dead	Giant	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/1/19/Dale.png	2022-11-27 09:15:43.99073	14	14
90	Daron Jefferson	alive	Cone-nippled alien	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/d/d2/Screenshot_2016-10-25_at_5.47.40_PM.png	2022-11-27 09:15:43.990747	28	28
91	David Letterman	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/3/32/David_Letterman.png	2022-11-27 09:15:43.990764	23	23
92	Davin	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/f/f9/Davin2.png	2022-11-27 09:15:43.990781	1	1
93	Diablo Verde	dead	Demon	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/4/41/DiabloVerdeVindicators2.png	2022-11-27 09:15:43.990798	\N	29
106	Dr. Schmidt	unknown	Game	human	male	https://static.wikia.nocookie.net/rickandmorty/images/1/1e/Dr._Schmidt.png	2022-11-27 09:15:43.991025	32	32
107	Dr. Wong	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/a/a4/Dr._Wong.png	2022-11-27 09:15:43.991042	20	20
110	Eli	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/0/08/Eli.png	2022-11-27 09:15:43.991095	8	8
111	Eli's Girlfriend	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/5/54/Eli%27s_Wife.png	2022-11-27 09:15:43.991116	8	8
112	Eric McMan	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/0/07/EricMcManTV.png	2022-11-27 09:15:43.991134	1	1
116	Evil Beth Clone	dead	Clone	human	female	https://static.wikia.nocookie.net/rickandmorty/images/3/3d/Evil_Beth_Clone.png	2022-11-27 09:15:43.991201	\N	1
117	Evil Jerry Clone	dead	Clone	human	male	https://static.wikia.nocookie.net/rickandmorty/images/1/17/Evil_Jerry_Clone.png	2022-11-27 09:15:43.991218	\N	1
118	Evil Morty	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/9/9c/EvilMortyInSpace.png	2022-11-27 09:15:43.991235	\N	3
119	Evil Rick	dead	Robot	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/d/d0/Evil_Rick_Close-Up.png	2022-11-27 09:15:43.991251	\N	3
120	Evil Summer Clone	dead	Clone	human	female	https://static.wikia.nocookie.net/rickandmorty/images/b/b4/Evil_Summer_Clone.png	2022-11-27 09:15:43.991268	\N	1
121	Eyehole Man	alive		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/3/3d/S2e8_Eyeholes_Man.png	2022-11-27 09:15:43.991285	\N	6
123	Fat Morty	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/0/06/S3e7_fat_morty.png	2022-11-27 09:15:43.991318	\N	3
124	Father Bob	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/9/96/Screenshot_2015-09-29_at_10.46.55_AM.png	2022-11-27 09:15:43.991336	20	20
126	Fleeb	unknown		alien	unknown	https://static.wikia.nocookie.net/rickandmorty/images/7/7a/Fleeb_%28Rick_and_Morty%29.png	2022-11-27 09:15:43.991369	\N	6
128	Frankenstein's Monster	dead	Parasite	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a7/Frankenstein%27s_Monster.png	2022-11-27 09:15:43.991403	\N	20
129	Fulgora	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/5/5a/Screenshot_2016-11-16_at_5.50.05_PM.png	2022-11-27 09:15:43.99142	\N	6
130	Galactic Federation President	dead	Gromflomite	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a5/GFPresident.png	2022-11-27 09:15:43.991437	\N	1
131	Gar Gloonch	dead	Zombodian	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/c/c7/Screenshot_2016-11-04_at_11.09.52_PM.png	2022-11-27 09:15:43.991454	\N	13
132	Gar's Mytholog	dead		mytholog	male	https://static.wikia.nocookie.net/rickandmorty/images/9/93/Screenshot_2016-11-04_at_11.10.54_PM.png	2022-11-27 09:15:43.991471	13	13
136	Gazorpazorpfield	alive	Gazorpian	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/8/88/Gaz.png	2022-11-27 09:15:43.991538	40	6
138	General Nathan	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/4a/GeneralNathan205.png	2022-11-27 09:15:43.991571	20	20
139	General Store Owner	dead	Cat-Person	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/d/de/General_Star.png	2022-11-27 09:15:43.991588	9	9
140	Genital Washer	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/7/7f/Genital_Washer.png	2022-11-27 09:15:43.991604	8	8
141	Ghost in a Jar	dead	Parasite, Ghost	alien	unknown	https://static.wikia.nocookie.net/rickandmorty/images/d/d7/Ghost_in_a_Jar_Picture.png	2022-11-27 09:15:43.991622	\N	20
143	Glasses Morty	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/9/94/Glassesmorty.png	2022-11-27 09:15:43.991655	\N	3
146	Glexo Slim Slom	alive		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/2/25/Screenshot_2015-09-28_at_8.07.59_AM.png	2022-11-27 09:15:43.991705	\N	13
147	Gobo	dead		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/f/f9/Goborm.png	2022-11-27 09:15:43.991721	\N	20
149	Gordon Lunas	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/42/Moonman.png	2022-11-27 09:15:43.991759	\N	20
150	Cornvelious Daniel	dead	Gromflomite	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/8/8f/S3e1_Cornvelious_Daniel.png	2022-11-27 09:15:43.991778	\N	39
151	Gwendolyn	unknown	Gazorpian reproduction robot	robot	female	https://static.wikia.nocookie.net/rickandmorty/images/8/8a/Gwendolyn_cropped.png	2022-11-27 09:15:43.991795	40	20
152	Hammerhead Morty	unknown	Hammerhead-Person	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/0/06/HammerMortyIMTJAH.png	2022-11-27 09:15:43.991812	\N	3
154	Hamurai	dead	Parasite	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/b/bd/Shut_Up_Hamurai.png	2022-11-27 09:15:43.991845	\N	20
155	Harold	alive		cronenberg	male	https://static.wikia.nocookie.net/rickandmorty/images/8/85/HaroldNews.png	2022-11-27 09:15:43.991862	1	1
156	Hemorrhage	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/1/10/Hambelridge.png	2022-11-27 09:15:43.991929	8	8
157	Hole in the Wall Where the Men Can See it All	unknown	Hole	unknown	unknown	https://static.wikia.nocookie.net/rickandmorty/images/b/b7/Hole_in_the_Wall_where_the_men_can_see_it_all.png	2022-11-27 09:15:43.991948	\N	6
158	Hookah Alien	alive	Tuskfish	alien	unknown	https://static.wikia.nocookie.net/rickandmorty/images/d/dd/S1e1_hookah.png	2022-11-27 09:15:43.991965	\N	38
159	Hunter	dead	Clone	human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/4b/Hunter.png	2022-11-27 09:15:43.991981	42	42
160	Hunter's Father	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/3/39/HuntersDad.png	2022-11-27 09:15:43.992002	42	42
161	Hydrogen-F	alive	Alphabetrian	alien	female	https://static.wikia.nocookie.net/rickandmorty/images/5/51/Hydrogen_F.png	2022-11-27 09:15:43.99202	43	43
163	Ideal Jerry	dead		mytholog	male	https://static.wikia.nocookie.net/rickandmorty/images/5/5a/Ideal_jerry.png	2022-11-27 09:15:43.992054	13	13
164	Insurance Rick	unknown		human	male	https://static.wikia.nocookie.net/rickandmorty/images/3/3e/Buy_Morty_Insurance.png	2022-11-27 09:15:43.992071	\N	3
165	Investigator Rick	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/c/c0/IMG_0161.png	2022-11-27 09:15:43.992088	\N	3
167	Izzy	alive	Cat	animal	unknown	https://static.wikia.nocookie.net/rickandmorty/images/b/b0/Izzy.png	2022-11-27 09:15:43.992122	20	20
168	Jackie	alive	Gazorpian	alien	female	https://static.wikia.nocookie.net/rickandmorty/images/9/92/Jackie_Gazorpian.png	2022-11-27 09:15:43.992139	40	40
169	Jacob	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/0/09/Jacob_Philip.png	2022-11-27 09:15:43.992156	1	1
170	Jacqueline	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/1/18/Jacqueline.png	2022-11-27 09:15:43.992172	20	20
171	Jaguar	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/2/2c/Jaguar1.png	2022-11-27 09:15:43.992189	20	20
172	Jamey	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/8/8a/S2e5_Jamey.png	2022-11-27 09:15:43.992205	20	20
173	Jan-Michael Vincent	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/0/07/S2e8_Jan.png	2022-11-27 09:15:43.992222	\N	6
175	Jerry Smith	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/f/f1/Jerry_Smith.png	2022-11-27 09:15:43.992256	1	1
177	Jerry Smith	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/f/f1/Jerry_Smith.png	2022-11-27 09:15:43.99229	34	34
178	Jerry's Mytholog	dead		mytholog	male	https://static.wikia.nocookie.net/rickandmorty/images/6/6e/Screenshot_2015-09-14_at_2.07.57_PM.png	2022-11-27 09:15:43.992307	13	13
179	Jessica	alive		cronenberg	female	https://static.wikia.nocookie.net/rickandmorty/images/e/e8/Jessica.png	2022-11-27 09:15:43.992324	1	1
180	Jessica	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/e/e8/Jessica.png	2022-11-27 09:15:43.992341	20	20
182	Jim	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/2/28/JimNews.png	2022-11-27 09:15:43.992375	20	20
183	Johnny Depp	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/8/89/Johnnydepp.png	2022-11-27 09:15:43.992391	23	23
184	Jon	alive	Gazorpian	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/3/37/Jon.png	2022-11-27 09:15:43.992409	40	6
187	Juggling Rick	unknown		human	male	https://static.wikia.nocookie.net/rickandmorty/images/5/5f/Jugglingrick.png	2022-11-27 09:15:43.992458	\N	3
188	Karen Entity	alive	Unknown-nippled alien	alien	female	https://static.wikia.nocookie.net/rickandmorty/images/8/81/Screenshot_2016-10-25_at_5.59.41_PM.png	2022-11-27 09:15:43.992475	28	28
190	Keara	alive	Krootabulan	alien	female	https://static.wikia.nocookie.net/rickandmorty/images/3/3c/Kiara.png	2022-11-27 09:15:43.992513	1	20
191	Kevin	dead	Zigerion	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/f/f1/Kevin.png	2022-11-27 09:15:43.99253	\N	46
192	King Flippy Nips	alive	Plutonian	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/6/62/King_Flippynips.png	2022-11-27 09:15:43.992547	47	47
193	King Jellybean	dead	Jellybean	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/f/fb/King_Jellybean.png	2022-11-27 09:15:43.992564	48	48
195	Kristen Stewart	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/2/28/Kristenstewart.png	2022-11-27 09:15:43.992598	23	23
196	Krombopulos Michael	dead	Gromflomite	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/9/93/Krombopulos_Michael.png	2022-11-27 09:15:43.992614	\N	1
197	Kyle	dead	Miniverse inhabitant	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/a/ad/Kyle.png	2022-11-27 09:15:43.992631	49	50
198	Lady Katana	dead	Cyborg	humanoid	female	https://static.wikia.nocookie.net/rickandmorty/images/3/37/LadyKatanaVindicators2.png	2022-11-27 09:15:43.992648	\N	29
200	Lawyer Morty	unknown		human	male	https://static.wikia.nocookie.net/rickandmorty/images/f/f9/Lawyer-NotLawyer_Morty.png	2022-11-27 09:15:43.992681	\N	3
201	Leonard Smith	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/7/74/Leonard_Smith.png	2022-11-27 09:15:43.992698	1	1
202	Lighthouse Keeper	dead	Cat-Person	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/5/55/LighthouseHQ.png	2022-11-27 09:15:43.992715	9	9
203	Lil B	dead	Snail alien	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/8/85/WeddingSinger.png	2022-11-27 09:15:43.992736	\N	35
186	Joyce Smith	alive		human	female	\N	2022-11-27 09:15:43.992442	1	1
204	Lisa	dead		alien	female	https://static.wikia.nocookie.net/rickandmorty/images/5/59/Lisa.png	2022-11-27 09:15:43.992753	\N	7
207	Loggins	alive	Alligator-Person	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/5/58/Loggins.transparent.png	2022-11-27 09:15:43.992803	\N	6
213	Magnesium-J	alive	Alphabetrian	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/1/13/Magnesium_J.png	2022-11-27 09:15:43.992903	43	43
214	Man Painted Silver Who Makes Robot Noises	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/b/b3/Man_Painted_Silver.png	2022-11-27 09:15:43.99292	\N	6
215	Maximums Rickimus	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/d/d9/Maximums_Rickimus.png	2022-11-27 09:15:43.992936	\N	3
216	MC Haps	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/46/MC_Haps.png	2022-11-27 09:15:43.992954	1	1
217	Mechanical Morty	dead		robot	male	https://static.wikia.nocookie.net/rickandmorty/images/1/17/Mechanical_Morty.png	2022-11-27 09:15:43.992971	20	20
218	Mechanical Rick	unknown		robot	male	https://static.wikia.nocookie.net/rickandmorty/images/6/60/Mechanical_Rick.png	2022-11-27 09:15:43.992988	20	20
219	Mechanical Summer	unknown		robot	female	https://static.wikia.nocookie.net/rickandmorty/images/a/ad/Mechanical_Summer.png	2022-11-27 09:15:43.993005	20	20
220	Mega Fruit Farmer Rick	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/c/c1/Megafruitfarmerrick.png	2022-11-27 09:15:43.993022	\N	3
221	Melissa	alive	Monster	humanoid	female	https://static.wikia.nocookie.net/rickandmorty/images/7/74/Melissa.png	2022-11-27 09:15:43.993038	18	18
224	Michael McLick	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/2/2f/Michael_McLick.png	2022-11-27 09:15:43.993132	\N	6
225	Michael Thompson	alive	Conjoined twin	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/f/fd/Michael_Thompson.png	2022-11-27 09:15:43.99315	\N	6
226	Million Ants	dead	Sentient ant colony	animal	male	https://static.wikia.nocookie.net/rickandmorty/images/0/05/Screenshot_%28101%29.png	2022-11-27 09:15:43.993167	\N	4
227	Mitch	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/3/33/Mitch.png	2022-11-27 09:15:43.993184	20	20
229	Morty Mart Manager Morty	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/7/7f/S3e7_store_ownder_morty.png	2022-11-27 09:15:43.993218	\N	3
232	Morty Smith	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/e/ee/Morty501.png	2022-11-27 09:15:43.993268	34	34
234	Morty Smith	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/e/ee/Morty501.png	2022-11-27 09:15:43.993302	20	20
236	Mr. Beauregard	dead	Parasite	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/9/97/MrBeauregard.png	2022-11-27 09:15:43.993335	\N	20
237	Mr. Benson	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/45/Screenshot_2016-11-05_at_10.11.46_PM.png	2022-11-27 09:15:43.993352	20	20
238	Mr. Booby Buyer	alive	Boobie buyer reptilian	animal	male	https://static.wikia.nocookie.net/rickandmorty/images/8/8a/Mr._Booby_Buyer.png	2022-11-27 09:15:43.993369	48	48
239	Mr. Goldenfold	alive		cronenberg	male	https://static.wikia.nocookie.net/rickandmorty/images/4/40/Mr._Goldenfold.png	2022-11-27 09:15:43.993386	1	1
240	Mr. Goldenfold	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/40/Mr._Goldenfold.png	2022-11-27 09:15:43.993403	20	20
241	Mr. Marklovitz	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/c/cd/Screenshot_2015-09-28_at_7.02.14_PM.png	2022-11-27 09:15:43.99342	1	20
242	Mr. Meeseeks	unknown	Meeseeks	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/6/6c/MeeseeksHQ.png	2022-11-27 09:15:43.993437	1	67
243	Mr. Needful	alive	The Devil	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/4/42/Mr.Needful.png	2022-11-27 09:15:43.993453	\N	20
244	Mr. Poopybutthole	alive		unknown	male	https://static.wikia.nocookie.net/rickandmorty/images/3/37/Mr_poopy_butthole.png	2022-11-27 09:15:43.993471	\N	1
245	Mrs. Lipkip	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/1/1d/Mrs._Lipkip.png	2022-11-27 09:15:43.993492	20	20
246	Mrs. Pancakes	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/b/bd/Mrs._Pancakes_Picture.png	2022-11-27 09:15:43.993508	1	18
247	Mrs. Poopybutthole	alive		unknown	female	https://static.wikia.nocookie.net/rickandmorty/images/9/97/Mrs._Poopybutthole.png	2022-11-27 09:15:43.993525	\N	1
248	Mrs. Refrigerator	dead	Parasite, Refrigerator	alien	female	https://static.wikia.nocookie.net/rickandmorty/images/c/cb/Mrs._Refridgerator.png	2022-11-27 09:15:43.993543	\N	20
250	Mrs. Sullivan	dead	Cat controlled dead lady	human	female	https://static.wikia.nocookie.net/rickandmorty/images/5/51/Mrs._Sullivan.png	2022-11-27 09:15:43.993576	23	6
251	Nancy	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/0/03/Nancy.png	2022-11-27 09:15:43.993593	20	20
252	Noob-Noob	alive		unknown	male	https://static.wikia.nocookie.net/rickandmorty/images/c/c8/Noob_Noob.png	2022-11-27 09:15:43.99361	\N	54
254	Octopus Man	alive	Octopus-Person	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/b/bc/Octopus_Man.png	2022-11-27 09:15:43.993644	\N	6
256	Pat Gueterman	dead		robot	male	https://static.wikia.nocookie.net/rickandmorty/images/6/64/Pat_Picture.png	2022-11-27 09:15:43.993678	\N	35
257	Paul Fleishman	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/1/10/Paul_Fleishmam.png	2022-11-27 09:15:43.993695	\N	44
258	Pawnshop Clerk	alive		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/a/af/PawnShopClerk.png	2022-11-27 09:15:43.993711	\N	55
259	Pencilvester	dead	Parasite, Pencil	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/7/7f/Pensylvester.png	2022-11-27 09:15:43.993728	\N	20
264	Pichael Thompson	alive	Conjoined twin	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/3/39/Pichael_Thompson.png	2022-11-27 09:15:43.993812	\N	6
267	Plumber Rick	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/0/06/Plumberrick.png	2022-11-27 09:15:43.993867	\N	3
268	Poncho	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/2/27/Poncho.png	2022-11-27 09:15:43.993884	\N	5
269	Presidentress of The Mega Gargantuans	alive	Mega Gargantuan	humanoid	female	https://static.wikia.nocookie.net/rickandmorty/images/1/1f/Presidentress_of_the_Mega_Gargantuants.png	2022-11-27 09:15:43.993902	56	56
270	Prince Nebulon	dead	Zigerion	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/8/8b/PrinceNebulon.png	2022-11-27 09:15:43.993919	\N	46
271	Principal Vagina	alive		cronenberg	male	https://static.wikia.nocookie.net/rickandmorty/images/4/4f/Principal_Vagina_S01_E09.png	2022-11-27 09:15:43.993936	1	1
272	Principal Vagina	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/4f/Principal_Vagina_S01_E09.png	2022-11-27 09:15:43.993953	20	20
273	Purge Planet Ruler	dead	Cat-Person	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/1/1e/Screenshot_2015-09-28_at_6.53.28_PM.png	2022-11-27 09:15:43.99397	9	9
274	Quantum Rick	unknown		human	male	https://static.wikia.nocookie.net/rickandmorty/images/7/79/QuantumRickS3.png	2022-11-27 09:15:43.993987	\N	3
275	Randy Dicknose	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a8/Randy_Dicknose.png	2022-11-27 09:15:43.994003	\N	6
276	Rat Boss	dead	Rat	animal	unknown	https://static.wikia.nocookie.net/rickandmorty/images/3/37/S3e3_rat_leader.png	2022-11-27 09:15:43.994023	20	20
277	Real Fake Doors Salesman	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/0/0c/Real_Fake_Doors_Salesman.png	2022-11-27 09:15:43.994041	\N	6
278	Regional Manager Rick	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/1/18/Wazzupbb.png	2022-11-27 09:15:43.994058	\N	3
279	Regular Legs	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/2/29/Regular_Legs.png	2022-11-27 09:15:43.994075	\N	6
280	Reverse Giraffe	dead	Parasite	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/8/8d/Reverse_Giraffe_Entire_Body.png	2022-11-27 09:15:43.994092	\N	20
282	Revolio Clockberg Jr.	unknown	Gear-Person	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/7/7d/Gearheadtransparent.png	2022-11-27 09:15:43.994125	57	57
283	Rick D. Sanchez III	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/c/cc/RickDSanchezIII.png	2022-11-27 09:15:43.994142	\N	3
284	Rick Guilt Rick	unknown		human	male	https://static.wikia.nocookie.net/rickandmorty/images/3/38/S3e7_rick_guilt_rick.png	2022-11-27 09:15:43.994158	\N	3
285	Rick Prime	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a1/WeirdRickNew.png	2022-11-27 09:15:43.994174	\N	3
290	Rick Sanchez	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a6/Rick_Sanchez.png	2022-11-27 09:15:43.994262	34	34
291	Rick J-22	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/c/cc/Sancherinobadderino.png	2022-11-27 09:15:43.994278	1	3
293	Rick Sanchez	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a6/Rick_Sanchez.png	2022-11-27 09:15:43.994311	20	20
294	Ricktiminus Sancheziminius	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/f/fc/Ricktiminus_Sancheziminius.png	2022-11-27 09:15:43.994327	\N	3
295	Riq IV	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/9/93/Riqiv.png	2022-11-27 09:15:43.994344	\N	3
296	Risotto Groupon	dead	Blue ape alien	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/d/dc/S3e5_mob.png	2022-11-27 09:15:43.994362	37	37
297	Risotto's Tentacled Henchman	dead	Tentacle alien	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/1/1c/S3e5_stolen_coat.png	2022-11-27 09:15:43.994379	37	37
298	Robot Morty	unknown		robot	male	https://static.wikia.nocookie.net/rickandmorty/images/5/55/Robot_Morty.png	2022-11-27 09:15:43.994395	\N	3
299	Robot Rick	unknown		robot	male	https://static.wikia.nocookie.net/rickandmorty/images/6/62/Robot-Rick.png	2022-11-27 09:15:43.994413	\N	3
300	Roger	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/1/13/Roger_from_anatomy_park2.png	2022-11-27 09:15:43.994434	1	5
301	Ron Benson	alive	Ring-nippled alien	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/d/d2/Screenshot_2016-10-25_at_5.40.02_PM.png	2022-11-27 09:15:43.994452	28	28
303	Samantha	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/7/7a/S1e5_what_the_fuck_is_going_on.png	2022-11-27 09:15:43.994485	1	1
304	Scary Brandon	alive	Monster	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/a/ac/Scary_Brandon.png	2022-11-27 09:15:43.994502	18	18
305	Scary Glenn	alive	Monster	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/d/d0/Scary_Glenn_Johnson.png	2022-11-27 09:15:43.994519	18	18
306	Scary Terry	alive	Monster	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/4/49/Scaryterry2.png	2022-11-27 09:15:43.994536	18	18
310	Self-Congratulatory Jerry	unknown		mytholog	male	https://static.wikia.nocookie.net/rickandmorty/images/9/9f/Scjerry.png	2022-11-27 09:15:43.994605	13	13
312	Shlaammi	alive		alien	unknown	https://static.wikia.nocookie.net/rickandmorty/images/b/bb/Shlami.png	2022-11-27 09:15:43.994638	\N	6
313	Shleemypants	alive	Omniscient being	unknown	male	https://static.wikia.nocookie.net/rickandmorty/images/4/4d/Shleemy.png	2022-11-27 09:15:43.994655	\N	1
314	Shmlamantha Shmlicelli	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/d/da/Screenshot_2016-11-21_at_6.42.44_PM.png	2022-11-27 09:15:43.994939	\N	6
315	Shmlangela Shmlobinson-Shmlower	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/9/9f/Screenshot_2016-11-21_at_6.43.44_PM.png	2022-11-27 09:15:43.994957	\N	6
316	Shmlona Shmlobinson	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/9/9f/Screenshot_2016-11-21_at_6.43.15_PM.png	2022-11-27 09:15:43.994974	\N	6
317	Shmlonathan Shmlower	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/a/ac/Screenshot_2016-11-21_at_6.42.16_PM.png	2022-11-27 09:15:43.994991	\N	6
318	Shmlony Shmlicelli	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/e/e6/Shmlony.png	2022-11-27 09:15:43.995007	\N	6
319	Shmooglite Runner	unknown	Animal	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/8/8a/S3e5_Shmooglite_attack.png	2022-11-27 09:15:43.995025	37	37
320	Shnoopy Bloopers	unknown		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/f/f2/S3e5_laughing.png	2022-11-27 09:15:43.995061	\N	7
321	Shrimply Pibbles	alive		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/2/22/S2e8_Shrimply_pibbles_records.png	2022-11-27 09:15:43.995078	\N	16
322	Simple Rick	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/8/8c/Howyoudoin%27bb.png	2022-11-27 09:15:43.995095	\N	3
323	Slaveowner	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/f/f0/Slaveowner.png	2022-11-27 09:15:43.995112	8	8
324	Sleepy Gary	dead	Parasite	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/9/9c/Sleepy_Gary_Better_Image.png	2022-11-27 09:15:43.995128	\N	20
325	Slick Morty	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/7/75/Slick_Morty.png	2022-11-27 09:15:43.995145	\N	3
328	Slow Rick	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/f/fb/Slowrick.png	2022-11-27 09:15:43.995195	\N	3
330	Solicitor Rick	unknown		human	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a2/Soliciter_Rick.png	2022-11-27 09:15:43.995236	\N	3
331	Squanchy	unknown	Cat-like creature	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/1/16/Squanchy_.png	2022-11-27 09:15:43.995258	35	35
332	Stacy	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/2/2d/Stacy.png	2022-11-27 09:15:43.995275	20	20
335	Steve	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/0/06/Steve_%28Secret_Service_Member%29.png	2022-11-27 09:15:43.995326	20	20
336	Steven Phillips	alive	Unknown-nippled alien	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a4/Screenshot_2016-10-25_at_5.24.25_PM.png	2022-11-27 09:15:43.995343	28	28
340	Supernova	alive	Superhuman	human	female	https://static.wikia.nocookie.net/rickandmorty/images/3/30/Supernova.png	2022-11-27 09:15:43.99541	\N	4
341	Taddy Mason	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/8/89/TaddyHQ.png	2022-11-27 09:15:43.995427	20	20
342	Taint Washer	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/3/3c/Taint_Washer.png	2022-11-27 09:15:43.995443	8	8
345	Teacher Rick	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/1/19/Teacherrick.png	2022-11-27 09:15:43.995502	\N	3
346	Terry	unknown		human	male	https://static.wikia.nocookie.net/rickandmorty/images/4/4c/TerryNews.png	2022-11-27 09:15:43.995521	20	20
347	The President	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/b/b1/President205.png	2022-11-27 09:15:43.995537	20	20
348	The President of the Miniverse	dead	Miniverse inhabitant	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/d/dd/President_of_the_Miniverse.png	2022-11-27 09:15:43.995555	49	49
349	The Scientist Formerly Known as Rick	dead		human	male	https://static.wikia.nocookie.net/rickandmorty/images/e/ec/SFKAR.png	2022-11-27 09:15:43.995571	\N	1
350	Thomas Lipkip	unknown		human	male	https://static.wikia.nocookie.net/rickandmorty/images/6/68/Tommy.png	2022-11-27 09:15:43.995588	20	63
351	Three Unknown Things	alive		alien	unknown	https://static.wikia.nocookie.net/rickandmorty/images/4/42/Three_Unknown_Things.png	2022-11-27 09:15:43.995605	\N	6
352	Tinkles	dead	Parasite, Unicorn lamb	alien	female	https://static.wikia.nocookie.net/rickandmorty/images/c/cb/Tinkles_Picture.png	2022-11-27 09:15:43.995622	\N	20
353	Tiny Rick	dead	Clone	human	male	https://static.wikia.nocookie.net/rickandmorty/images/2/23/TinyRick.png	2022-11-27 09:15:43.995639	20	20
354	Toby Matthews	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/7/7d/Screenshot_2015-09-14_at_2.05.38_PM.png	2022-11-27 09:15:43.995656	20	20
355	Todd Crystal	alive	Unknown-nippled alien	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/8/84/Screenshot_2016-10-25_at_5.58.46_PM.png	2022-11-27 09:15:43.995673	28	28
356	Tom Randolph	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/5/53/TomRandolphTV.png	2022-11-27 09:15:43.99569	1	1
357	Tommy's Clone	alive	Clone	human	male	https://static.wikia.nocookie.net/rickandmorty/images/5/51/Tommy%27s_Clone.png	2022-11-27 09:15:43.995706	20	20
358	Tophat Jones	dead	Leprechaun	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/1/1b/Tophatjones.png	2022-11-27 09:15:43.995723	\N	6
360	Toxic Morty	dead	Morty's toxic side	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/6/64/Toxic_Morty.png	2022-11-27 09:15:43.995756	1	20
361	Toxic Rick	dead	Rick's toxic side	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/3/3e/Toxic_Rick_Fixed_Transparent_by_Mixo.png	2022-11-27 09:15:43.995773	1	20
363	Trandor	alive	Krootabulan	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/8/88/Trandor.png	2022-11-27 09:15:43.995806	1	20
365	Tricia Lange	alive		human	female	https://static.wikia.nocookie.net/rickandmorty/images/c/c2/TriciaLang.png	2022-11-27 09:15:43.99584	20	20
366	Trunk Morty	alive	Trunk-Person	humanoid	male	https://static.wikia.nocookie.net/rickandmorty/images/8/8c/S3e7_trunk_person_morty.png	2022-11-27 09:15:43.995856	1	3
368	Truth Tortoise	unknown	Omniscient being	animal	male	https://static.wikia.nocookie.net/rickandmorty/images/4/4e/Rm.s03e08.s01.png	2022-11-27 09:15:43.99589	\N	1
369	Tusked Assassin	unknown	Tuskfish	alien	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a4/S3e5_assassins_ride.png	2022-11-27 09:15:43.995907	37	37
370	Two Guys with Handlebar Mustaches	alive		human	male	https://static.wikia.nocookie.net/rickandmorty/images/2/2a/Two_Guys_with_Handlebar_Mustaches.png	2022-11-27 09:15:43.995924	\N	6
372	Unity	alive	Hivemind	alien	unknown	https://static.wikia.nocookie.net/rickandmorty/images/f/f4/Unity_by_Mixo.png	2022-11-27 09:15:43.995961	\N	28
376	Veronica Ann Bennet	alive	Gazorpian	alien	female	https://static.wikia.nocookie.net/rickandmorty/images/d/df/Veronica_Ann_Bennet.png	2022-11-27 09:15:43.99603	40	40
379	Wedding Bartender	unknown		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/8/82/S2e10_bartender.png	2022-11-27 09:15:43.996079	\N	35
380	Weird Rick	unknown		human	male	https://static.wikia.nocookie.net/rickandmorty/images/a/a1/WeirdRickNew.png	2022-11-27 09:15:43.996096	\N	1
382	Worldender	dead		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/d/d2/Screen_shot_2017-08-12_at_10.51.18_PM.png	2022-11-27 09:15:43.996129	\N	4
383	Yaarb	alive		alien	male	https://static.wikia.nocookie.net/rickandmorty/images/8/85/BrownDiplomatAlien.png	2022-11-27 09:15:43.996145	\N	16
326	Slippery Stair	alive	Slug	animal	male	\N	2022-11-27 09:15:43.995162	48	20
386	Zarbadar Gloonch	dead	Drumbloxian	alien	female	https://static.wikia.nocookie.net/rickandmorty/images/9/9a/Screenshot_2016-11-04_at_11.08.57_PM.png	2022-11-27 09:15:43.996195	\N	13
\.


--
-- Data for Name: episode_characters; Type: TABLE DATA; Schema: public; Owner: hack_api_user
--

COPY public.episode_characters (id, character_id, episode_id) FROM stdin;
1	1	1
2	2	1
3	35	1
4	38	1
5	62	1
6	92	1
7	127	1
8	144	1
9	158	1
10	175	1
11	179	1
12	181	1
13	239	1
14	249	1
15	271	1
16	338	1
17	394	1
18	395	1
19	435	1
20	1	2
21	2	2
22	38	2
23	46	2
24	63	2
25	80	2
26	175	2
27	221	2
28	239	2
29	246	2
30	304	2
31	305	2
32	306	2
33	329	2
34	338	2
35	396	2
36	397	2
37	398	2
38	405	2
39	1	3
40	2	3
41	12	3
42	17	3
43	38	3
44	45	3
45	96	3
46	97	3
47	98	3
48	99	3
49	100	3
50	101	3
51	108	3
52	112	3
53	114	3
54	169	3
55	175	3
56	186	3
57	201	3
58	268	3
59	300	3
60	302	3
61	338	3
62	356	3
63	1	4
64	2	4
65	38	4
66	87	4
67	175	4
68	179	4
69	181	4
70	191	4
71	239	4
72	241	4
73	270	4
74	337	4
75	338	4
76	1	5
77	2	5
78	38	5
79	41	5
80	89	5
81	116	5
82	117	5
83	120	5
84	175	5
85	193	5
86	238	5
87	242	5
88	271	5
89	303	5
90	326	5
91	333	5
92	338	5
93	343	5
94	399	5
95	400	5
96	1	6
97	2	6
98	3	6
99	4	6
100	5	6
101	38	6
102	58	6
103	82	6
104	83	6
105	92	6
106	155	6
107	175	6
108	179	6
109	181	6
110	216	6
111	234	6
112	239	6
113	249	6
114	251	6
115	271	6
116	293	6
117	338	6
118	343	6
119	394	6
120	1	7
121	2	7
122	3	7
123	4	7
124	5	7
125	59	7
126	151	7
127	168	7
128	211	7
129	230	7
130	258	7
131	329	7
132	376	7
133	401	7
134	1	8
135	2	8
136	3	8
137	4	8
138	5	8
139	20	8
140	28	8
141	29	8
142	34	8
143	37	8
144	54	8
145	88	8
146	91	8
147	129	8
148	134	8
149	136	8
150	145	8
151	153	8
152	157	8
153	176	8
154	183	8
155	184	8
156	195	8
157	207	8
158	214	8
159	222	8
160	250	8
161	266	8
162	277	8
163	279	8
164	314	8
165	315	8
166	316	8
167	317	8
168	318	8
169	351	8
170	358	8
171	367	8
172	370	8
173	373	8
174	402	8
175	403	8
176	404	8
177	405	8
178	406	8
179	407	8
180	408	8
181	409	8
182	410	8
183	411	8
184	412	8
185	413	8
186	414	8
187	415	8
188	416	8
189	417	8
190	418	8
191	1	9
192	2	9
193	3	9
194	4	9
195	5	9
196	88	9
197	192	9
198	240	9
199	243	9
200	251	9
201	272	9
202	307	9
203	419	9
204	420	9
205	421	9
206	422	9
207	1	10
208	2	10
209	3	10
210	4	10
211	5	10
212	7	10
213	14	10
214	15	10
215	18	10
216	19	10
217	21	10
218	22	10
219	27	10
220	39	10
221	53	10
222	77	10
223	78	10
224	79	10
225	82	10
226	83	10
227	84	10
228	85	10
229	86	10
230	103	10
231	113	10
232	118	10
233	119	10
234	152	10
235	164	10
236	177	10
237	209	10
238	215	10
239	232	10
240	242	10
241	274	10
242	285	10
243	290	10
244	294	10
245	295	10
246	298	10
247	299	10
248	329	10
249	330	10
250	339	10
251	349	10
252	359	10
253	381	10
254	389	10
255	405	10
256	424	10
257	425	10
258	426	10
259	427	10
260	428	10
261	429	10
262	430	10
263	431	10
264	432	10
265	433	10
266	434	10
267	1	11
268	2	11
269	3	11
270	4	11
271	5	11
272	7	11
273	47	11
274	58	11
275	88	11
276	180	11
277	181	11
278	210	11
279	216	11
280	251	11
281	282	11
282	295	11
283	308	11
284	326	11
285	327	11
286	331	11
287	333	11
288	344	11
289	362	11
290	389	11
291	395	11
292	405	11
293	423	11
294	435	11
295	436	11
296	35	11
297	1	12
298	2	12
299	3	12
300	4	12
301	5	12
302	11	12
303	64	12
304	237	12
305	313	12
306	437	12
307	438	12
308	439	12
309	440	12
310	1	13
311	2	13
312	5	13
313	23	13
314	28	13
315	34	13
316	106	13
317	122	13
318	129	13
319	131	13
320	133	13
321	136	13
322	174	13
323	180	13
324	196	13
325	207	13
326	242	13
327	257	13
328	282	13
329	309	13
330	311	13
331	362	13
332	393	13
333	436	13
334	441	13
335	442	13
336	443	13
337	444	13
338	445	13
339	446	13
340	447	13
341	448	13
342	449	13
343	450	13
344	451	13
345	386	13
346	1	14
347	2	14
348	3	14
349	4	14
350	5	14
351	36	14
352	50	14
353	90	14
354	188	14
355	249	14
356	301	14
357	336	14
358	355	14
359	372	14
360	1	15
361	2	15
362	3	15
363	4	15
364	5	15
365	16	15
366	31	15
367	32	15
368	76	15
369	109	15
370	128	15
371	141	15
372	154	15
373	169	15
374	236	15
375	244	15
376	248	15
377	259	15
378	262	15
379	280	15
380	324	15
381	329	15
382	352	15
383	391	15
384	1	16
385	2	16
386	3	16
387	4	16
388	5	16
389	24	16
390	47	16
391	115	16
392	124	16
393	138	16
394	161	16
395	162	16
396	172	16
397	182	16
398	199	16
399	212	16
400	213	16
401	240	16
402	241	16
403	253	16
404	255	16
405	272	16
406	309	16
407	329	16
408	331	16
409	344	16
410	346	16
411	347	16
412	395	16
413	452	16
414	454	16
415	1	17
416	2	17
417	3	17
418	28	17
419	34	17
420	65	17
421	129	17
422	159	17
423	160	17
424	180	17
425	181	17
426	197	17
427	207	17
428	240	17
429	266	17
430	348	17
431	364	17
432	388	17
433	1	18
434	2	18
435	3	18
436	4	18
437	5	18
438	40	18
439	55	18
440	66	18
441	131	18
442	132	18
443	146	18
444	148	18
445	163	18
446	178	18
447	180	18
448	181	18
449	240	18
450	272	18
451	310	18
452	353	18
453	354	18
454	358	18
455	374	18
456	386	18
457	387	18
458	453	18
459	1	19
460	2	19
461	3	19
462	4	19
463	5	19
464	23	19
465	49	19
466	51	19
467	105	19
468	121	19
469	126	19
470	133	19
471	153	19
472	173	19
473	199	19
474	205	19
475	223	19
476	224	19
477	225	19
478	254	19
479	260	19
480	263	19
481	264	19
482	275	19
483	312	19
484	321	19
485	334	19
486	362	19
487	371	19
488	383	19
489	384	19
490	454	19
491	455	19
492	456	19
493	35	19
494	435	19
495	457	19
496	458	19
497	459	19
498	460	19
499	1	20
500	2	20
501	3	20
502	4	20
503	5	20
504	26	20
505	139	20
506	202	20
507	273	20
508	341	20
509	1	21
510	2	21
511	3	21
512	4	21
513	5	21
514	23	21
515	47	21
516	75	21
517	102	21
518	130	21
519	131	21
520	133	21
521	194	21
522	199	21
523	203	21
524	240	21
525	244	21
526	256	21
527	261	21
528	308	21
529	311	21
530	331	21
531	344	21
532	358	21
533	362	21
534	379	21
535	55	21
536	309	21
537	454	21
538	1	22
539	2	22
540	3	22
541	4	22
542	5	22
543	21	22
544	22	22
545	38	22
546	42	22
547	47	22
548	48	22
549	57	22
550	69	22
551	71	22
552	86	22
553	94	22
554	95	22
555	103	22
556	150	22
557	152	22
558	175	22
559	200	22
560	215	22
561	231	22
562	240	22
563	274	22
564	285	22
565	286	22
566	294	22
567	295	22
568	330	22
569	338	22
570	344	22
571	378	22
572	380	22
573	385	22
574	389	22
575	461	22
576	462	22
577	463	22
578	464	22
579	465	22
580	466	22
581	1	23
582	2	23
583	3	23
584	4	23
585	5	23
586	25	23
587	52	23
588	68	23
589	110	23
590	111	23
591	140	23
592	156	23
593	217	23
594	218	23
595	219	23
596	228	23
597	323	23
598	342	23
599	1	24
600	2	24
601	3	24
602	4	24
603	9	24
604	70	24
605	107	24
606	167	24
607	171	24
608	189	24
609	240	24
610	265	24
611	272	24
612	276	24
613	329	24
614	1	25
615	2	25
616	3	25
617	4	25
618	10	25
619	23	25
620	60	25
621	81	25
622	93	25
623	104	25
624	181	25
625	198	25
626	208	25
627	226	25
628	251	25
629	252	25
630	282	25
631	311	25
632	333	25
633	340	25
634	362	25
635	375	25
636	382	25
637	395	25
638	88	25
639	309	25
640	35	25
641	435	25
642	216	25
643	125	25
644	1	26
645	2	26
646	3	26
647	4	26
648	5	26
649	23	26
650	47	26
651	115	26
652	137	26
653	142	26
654	180	26
655	204	26
656	296	26
657	297	26
658	319	26
659	320	26
660	365	26
661	369	26
662	467	26
663	468	26
664	469	26
665	1	27
666	2	27
667	3	27
668	4	27
669	6	27
670	124	27
671	170	27
672	180	27
673	181	27
674	227	27
675	240	27
676	246	27
677	272	27
678	332	27
679	360	27
680	361	27
681	365	27
682	470	27
683	471	27
684	1	28
685	2	28
686	4	28
687	8	28
688	18	28
689	22	28
690	27	28
691	43	28
692	44	28
693	48	28
694	56	28
695	61	28
696	72	28
697	73	28
698	74	28
699	78	28
700	85	28
701	86	28
702	118	28
703	123	28
704	135	28
705	143	28
706	165	28
707	180	28
708	187	28
709	206	28
710	220	28
711	229	28
712	233	28
713	235	28
714	267	28
715	278	28
716	281	28
717	283	28
718	284	28
719	287	28
720	288	28
721	289	28
722	291	28
723	292	28
724	322	28
725	325	28
726	328	28
727	345	28
728	366	28
729	367	28
730	472	28
731	473	28
732	392	28
733	474	28
734	475	28
735	476	28
736	477	28
737	478	28
738	479	28
739	480	28
740	481	28
741	482	28
742	483	28
743	484	28
744	485	28
745	486	28
746	487	28
747	488	28
748	489	28
749	1	29
750	2	29
751	3	29
752	4	29
753	5	29
754	33	29
755	67	29
756	147	29
757	149	29
758	180	29
759	242	29
760	244	29
761	251	29
762	272	29
763	329	29
764	368	29
765	377	29
766	390	29
767	490	29
768	491	29
769	1	30
770	2	30
771	3	30
772	4	30
773	5	30
774	58	30
775	180	30
776	185	30
777	190	30
778	240	30
779	244	30
780	245	30
781	249	30
782	329	30
783	350	30
784	357	30
785	363	30
786	492	30
787	1	31
788	2	31
789	3	31
790	4	31
791	5	31
792	13	31
793	30	31
794	166	31
795	244	31
796	247	31
797	269	31
798	335	31
799	347	31
800	493	31
\.


--
-- Data for Name: episodes; Type: TABLE DATA; Schema: public; Owner: hack_api_user
--

COPY public.episodes (id, name, air_date, season, episode_number) FROM stdin;
1	Pilot	2013-12-02	1	1
2	Lawnmower Dog	2013-12-09	1	2
3	Anatomy Park	2013-12-16	1	3
4	M. Night Shaym-Aliens!	2014-01-13	1	4
5	Meeseeks and Destroy	2014-01-20	1	5
6	Rick Potion #9	2014-01-27	1	6
7	Raising Gazorpazorp	2014-03-10	1	7
8	Rixty Minutes	2014-03-17	1	8
9	Something Ricked This Way Comes	2014-03-24	1	9
10	Close Rick-counters of the Rick Kind	2014-04-07	1	10
11	Ricksy Business	2014-04-14	1	11
12	A Rickle in Time	2015-07-26	2	1
13	Mortynight Run	2015-08-02	2	2
14	Auto Erotic Assimilation	2015-08-09	2	3
15	Total Rickall	2015-08-16	2	4
16	Get Schwifty	2015-08-23	2	5
17	The Ricks Must Be Crazy	2015-08-30	2	6
18	Big Trouble in Little Sanchez	2015-09-13	2	7
19	Interdimensional Cable 2: Tempting Fate	2015-09-20	2	8
20	Look Who's Purging Now	2015-09-27	2	9
21	The Wedding Squanchers	2015-10-04	2	10
22	The Rickshank Rickdemption	2017-04-01	3	1
23	Rickmancing the Stone	2017-07-30	3	2
24	Pickle Rick	2017-08-06	3	3
25	Vindicators 3: The Return of Worldender	2017-08-13	3	4
26	The Whirly Dirly Conspiracy	2017-08-20	3	5
27	Rest and Ricklaxation	2017-08-27	3	6
28	The Ricklantis Mixup	2017-09-10	3	7
29	Morty's Mind Blowers	2017-09-17	3	8
30	The ABC's of Beth	2017-09-24	3	9
31	The Rickchurian Mortydate	2017-10-01	3	10
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: hack_api_user
--

COPY public.locations (id, name, dimension, created_at, type) FROM stdin;
1	Earth (C-137)	c_137	2022-11-27 09:15:43.378884	planet
2	Abadango	unknown	2022-11-27 09:15:43.378919	cluster
3	Citadel of Ricks	unknown	2022-11-27 09:15:43.378934	unknown
4	Worldender's lair	unknown	2022-11-27 09:15:43.378947	planet
5	Anatomy Park	c_137	2022-11-27 09:15:43.378959	microverse
6	Interdimensional Cable	unknown	2022-11-27 09:15:43.378973	tv
7	Immortality Field Resort	unknown	2022-11-27 09:15:43.378984	resort
8	Post-Apocalyptic Earth	post_apocalyptic_dimension	2022-11-27 09:15:43.378999	planet
9	Purge Planet	replacement_dimension	2022-11-27 09:15:43.379012	planet
10	Venzenulon 7	unknown	2022-11-27 09:15:43.379027	planet
11	Bepis 9	unknown	2022-11-27 09:15:43.379038	planet
13	Nuptia 4	unknown	2022-11-27 09:15:43.379049	planet
14	Giant's Town	fantasy_dimension	2022-11-27 09:15:43.379062	unknown
16	St. Gloopy Noops Hospital	unknown	2022-11-27 09:15:43.379074	unknown
18	Mr. Goldenfold's dream	c_137	2022-11-27 09:15:43.379085	dream
20	Earth (Replacement Dimension)	replacement_dimension	2022-11-27 09:15:43.379098	planet
21	Testicle Monster Dimension	testicle_monster_dimension	2022-11-27 09:15:43.37911	unknown
22	Signus 5 Expanse	chair_dimension	2022-11-27 09:15:43.379122	unknown
23	Earth (C-500A)	c_500_a	2022-11-27 09:15:43.379134	planet
24	Rick's Battery Microverse	replacement_dimension	2022-11-27 09:15:43.379146	microverse
25	The Menagerie	unknown	2022-11-27 09:15:43.379159	menagerie
27	Hideout Planet	unknown	2022-11-27 09:15:43.37917	planet
28	Unity's Planet	replacement_dimension	2022-11-27 09:15:43.379181	planet
29	Dorian 5	replacement_dimension	2022-11-27 09:15:43.379192	planet
30	Earth (Unknown dimension)	unknown	2022-11-27 09:15:43.379204	planet
32	Roy: A Life Well Lived	replacement_dimension	2022-11-27 09:15:43.379215	game
34	Earth (Evil Rick's Target Dimension)	replacement_dimension	2022-11-27 09:15:43.379227	planet
35	Planet Squanch	replacement_dimension	2022-11-27 09:15:43.379239	planet
37	Resort Planet	unknown	2022-11-27 09:15:43.379251	planet
38	Interdimensional Customs	unknown	2022-11-27 09:15:43.379261	unknown
39	Galactic Federation Prison	unknown	2022-11-27 09:15:43.379272	unknown
40	Gazorpazorp	unknown	2022-11-27 09:15:43.379282	planet
41	Hamster in Butt World	unknown	2022-11-27 09:15:43.379292	planet
42	Earth (Giant Telepathic Spiders Dimension)	giant_telepathic_spiders_dimension	2022-11-27 09:15:43.379302	planet
43	Alphabetrium	replacement_dimension	2022-11-27 09:15:43.379315	planet
44	Jerryboree	unknown	2022-11-27 09:15:43.379326	unknown
46	Zigerion's Base	c_137	2022-11-27 09:15:43.379336	unknown
47	Pluto	replacement_dimension	2022-11-27 09:15:43.379347	unknown
48	Fantasy World	fantasy_dimension	2022-11-27 09:15:43.379358	planet
49	Zeep Xanflorp's Miniverse	replacement_dimension	2022-11-27 09:15:43.379369	miniverse
50	Kyle's Teenyverse	replacement_dimension	2022-11-27 09:15:43.37938	teenyverse
54	Vindicator's Base	unknown	2022-11-27 09:15:43.379395	unknown
55	Pawn Shop Planet	replacement_dimension	2022-11-27 09:15:43.379406	planet
56	Mega Gargantuan Kingdom	replacement_dimension	2022-11-27 09:15:43.379417	microverse
57	Gear World	unknown	2022-11-27 09:15:43.379428	planet
63	Froopyland	replacement_dimension	2022-11-27 09:15:43.379438	unknown
66	Plopstar	unknown	2022-11-27 09:15:43.379449	planet
67	Blips and Chitz	replacement_dimension	2022-11-27 09:15:43.379459	unknown
70	Snuffles' Dream	c_137	2022-11-27 09:15:43.37947	dream
71	Earth (Pizza Dimension)	pizza_dimension	2022-11-27 09:15:43.379481	planet
72	Earth (Phone Dimension)	phone_dimension	2022-11-27 09:15:43.379492	planet
73	Greasy Grandma World	unknown	2022-11-27 09:15:43.379503	planet
74	Earth (Chair Dimension)	chair_dimension	2022-11-27 09:15:43.379513	planet
76	Alien Day Spa	unknown	2022-11-27 09:15:43.379525	unknown
\.


--
-- Name: adventure_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hack_api_user
--

SELECT pg_catalog.setval('public.adventure_participants_id_seq', 1, false);


--
-- Name: adventures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hack_api_user
--

SELECT pg_catalog.setval('public.adventures_id_seq', 1, false);


--
-- Name: characters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hack_api_user
--

SELECT pg_catalog.setval('public.characters_id_seq', 1, false);


--
-- Name: episode_characters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hack_api_user
--

SELECT pg_catalog.setval('public.episode_characters_id_seq', 800, true);


--
-- Name: episodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hack_api_user
--

SELECT pg_catalog.setval('public.episodes_id_seq', 1, false);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: hack_api_user
--

SELECT pg_catalog.setval('public.locations_id_seq', 1, false);


--
-- Name: adventure_participants adventure_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.adventure_participants
    ADD CONSTRAINT adventure_participants_pkey PRIMARY KEY (id);


--
-- Name: adventures adventures_pkey; Type: CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.adventures
    ADD CONSTRAINT adventures_pkey PRIMARY KEY (id);


--
-- Name: characters characters_pkey; Type: CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (id);


--
-- Name: episode_characters episode_characters_pkey; Type: CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.episode_characters
    ADD CONSTRAINT episode_characters_pkey PRIMARY KEY (id);


--
-- Name: episodes episodes_pkey; Type: CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.episodes
    ADD CONSTRAINT episodes_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: adventure_participants adventure_participants_adventure_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.adventure_participants
    ADD CONSTRAINT adventure_participants_adventure_id_fkey FOREIGN KEY (adventure_id) REFERENCES public.adventures(id);


--
-- Name: adventure_participants adventure_participants_participant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.adventure_participants
    ADD CONSTRAINT adventure_participants_participant_id_fkey FOREIGN KEY (participant_id) REFERENCES public.characters(id);


--
-- Name: adventures adventures_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.adventures
    ADD CONSTRAINT adventures_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: characters characters_current_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_current_location_id_fkey FOREIGN KEY (current_location_id) REFERENCES public.locations(id) ON DELETE CASCADE;


--
-- Name: characters characters_origin_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_origin_location_id_fkey FOREIGN KEY (origin_location_id) REFERENCES public.locations(id) ON DELETE CASCADE;


--
-- Name: episode_characters episode_characters_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.episode_characters
    ADD CONSTRAINT episode_characters_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(id);


--
-- Name: episode_characters episode_characters_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hack_api_user
--

ALTER TABLE ONLY public.episode_characters
    ADD CONSTRAINT episode_characters_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES public.episodes(id);


--
-- PostgreSQL database dump complete
--

