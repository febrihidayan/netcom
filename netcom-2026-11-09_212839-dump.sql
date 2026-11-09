--
-- PostgreSQL database dump
--

\restrict 9h6FdlIKauJD8BQbrUaHWG70dh3c0tZeubeWqyfpVGf4idHdB7BHtlDKdgszu7W

-- Dumped from database version 18.0 (Homebrew)
-- Dumped by pg_dump version 18.0 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: febrihidayan
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO febrihidayan;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: febrihidayan
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id uuid NOT NULL,
    customer_name character varying(255),
    customer_zip_code_prefix character varying(255),
    customer_city character varying(255),
    customer_state character varying(10),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection character varying(255) NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: geolocations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.geolocations (
    geolocation_zip_code_prefix character varying(255) NOT NULL,
    geolocation_lat numeric(10,8),
    geolocation_lng numeric(11,8),
    geolocation_city character varying(255),
    geolocation_state character varying(10),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.geolocations OWNER TO postgres;

--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id uuid NOT NULL,
    order_id uuid NOT NULL,
    order_item_id integer NOT NULL,
    product_id uuid NOT NULL,
    seller_id uuid NOT NULL,
    shipping_limit_date timestamp(0) without time zone,
    price numeric(10,2) NOT NULL,
    freight_value numeric(10,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_payments (
    id uuid NOT NULL,
    order_id uuid NOT NULL,
    payment_sequential integer NOT NULL,
    payment_type character varying(255) NOT NULL,
    payment_installments integer NOT NULL,
    payment_value numeric(10,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.order_payments OWNER TO postgres;

--
-- Name: order_reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_reviews (
    id uuid NOT NULL,
    order_id uuid NOT NULL,
    review_score integer NOT NULL,
    review_comment_title character varying(255),
    review_comment_message text,
    review_creation_date timestamp(0) without time zone,
    review_answer_timestamp timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.order_reviews OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid NOT NULL,
    customer_id uuid NOT NULL,
    order_status character varying(255) NOT NULL,
    order_purchase_timestamp timestamp(0) without time zone,
    order_approved_at timestamp(0) without time zone,
    order_delivered_carrier_date timestamp(0) without time zone,
    order_delivered_customer_date timestamp(0) without time zone,
    order_estimated_delivery_date timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: passkeys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passkeys (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    credential_id character varying(255) NOT NULL,
    credential json NOT NULL,
    last_used_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.passkeys OWNER TO postgres;

--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- Name: product_category_translations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_category_translations (
    product_category_name character varying(255) NOT NULL,
    product_category_name_english character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.product_category_translations OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id uuid NOT NULL,
    product_category_name character varying(255),
    product_name_length integer,
    product_description_length integer,
    product_photos_qty integer,
    product_weight_g numeric(10,2),
    product_length_cm numeric(10,2),
    product_height_cm numeric(10,2),
    product_width_cm numeric(10,2),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: sellers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sellers (
    id uuid NOT NULL,
    seller_zip_code_prefix character varying(255),
    seller_city character varying(255),
    seller_state character varying(10),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.sellers OWNER TO postgres;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id uuid,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    two_factor_secret text,
    two_factor_recovery_codes text,
    two_factor_confirmed_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
laravel-cache-22d858805dc30c8d8b9c1f802cabf780:timer	i:1794229949;	1794229949
laravel-cache-22d858805dc30c8d8b9c1f802cabf780	i:1;	1794229949
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, customer_name, customer_zip_code_prefix, customer_city, customer_state, created_at, updated_at) FROM stdin;
01a1c06e-d0b8-7355-853d-993bf571e336	Mrs. Josie Abbott PhD	39875-2689	McKenzietown	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0ba-71df-9e4a-2e123b64119a	Hallie Gibson IV	12173-6341	South Marquisstad	LA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0bb-7218-ba26-0e45b8464733	Sigrid Turcotte	38804-9895	North Elinoreport	DC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0bb-7218-ba26-0e45b8a8fd73	Alexanne Runolfsson	99815-9184	Braulioland	ID	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0bd-72af-b7fa-36d79e695934	Kayley Sporer	43438-1872	Lake Ryderborough	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0bf-71e7-bca9-331bb90c04e4	Mr. Sherwood Pacocha	08589	Jaymouth	DC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0c0-723e-b601-d00b4201e5d8	Prince Graham	67389	Macburgh	MI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0c3-727a-adfa-3b9f4186e864	Prof. Bartholome Goodwin III	91506	South Abigaleton	TN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0c4-72bd-bd90-3c3234c865d6	Emilie Luettgen	55121	Heathcotestad	OH	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0c5-73dd-b1dc-7538b573de87	Bernita Ratke	75597-8093	West Angiemouth	MI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0c9-723c-8497-890e1344607c	Bruce Schmidt	26639-5650	North Jean	UT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0cb-70a7-9bcd-945b7b5c8ac5	Elza Runte	21160	Georgiannaberg	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0cc-712a-bcdb-ffab75ceb880	Harvey Steuber	53888	Tiffanystad	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0ce-7371-a70e-1e63b1d18296	Lexus Howell	42540-4834	Port Jakaylamouth	CA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0cf-73d7-8512-17b2c9bab16b	Prof. Kenna Ebert	19757	Port Jordyntown	NH	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0d0-70cc-bc49-859215257b58	Dr. Maximillia Denesik	38820-9240	Clarissaburgh	CT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0d1-7216-bb3f-819cdc03323c	Antoinette Goldner	28119-0814	Beahanland	AK	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0d2-7249-8c8c-b72d4c7eefa8	Joshua Moore	25989	Jermaineburgh	AL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0d3-7011-b5e3-904f43ae8aea	Dr. Jannie Bahringer	20527	Windlerhaven	AK	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0d4-7108-ab21-fc468c71101e	Mr. Colin Schulist Sr.	37063-1623	Orlostad	OK	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0d5-7249-b43b-a896c22a3a76	Dangelo Leannon	10092	McCulloughhaven	OH	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0d6-71b3-a1ab-f9645323696a	Miss Abigail Schneider I	11997-2859	Ankundingfurt	DC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0d6-71b3-a1ab-f9645391b03a	Jaylan Spinka	48075-5769	Muellerchester	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0d7-71df-92a3-dda51523818c	Elinore Hill	05257-8745	East Tiana	DC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0db-7226-a455-8ac0b4dad878	Maye Gibson IV	74806	Lake Josephine	PA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0f0-70e2-9bdd-0f1cd4779d01	Ms. Carlotta Kozey Sr.	49621-2028	Bauchchester	VA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0f1-7310-8feb-97245b96e0e7	Mr. Jaycee Bogan	41051-0062	South Aidan	MA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0f3-7389-80b8-da76d09cbab9	Kennith Towne	56977-4456	East Kieranhaven	MI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0f4-72a1-8c35-77b83ae751bc	Dr. Delilah Stehr	22576-3051	Gennaroside	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0f9-7171-8c4c-13483e3319af	Dr. Frederique Reinger IV	72132-8493	Lake Stephania	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0fb-718b-948b-b1f54e64d280	Dr. Westley Schoen IV	60682	Charleneville	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d0fe-71d4-a548-fad3351bdec6	Kristopher Graham	49042-8824	Harberton	CT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d108-719b-b2cc-321c7daafa96	Dr. Craig Predovic III	41917-6485	North Ilianamouth	MI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d114-70a8-a96a-7d06f2e0e310	Mr. Lamont Pollich	60826	North Estaville	VA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d115-73c4-90f6-20876b073ea7	Catalina Braun	51048	Allantown	NC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d116-73a5-a2c1-393bd2472ed1	Lesley Rowe Jr.	62254-1498	North Deion	NV	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d118-7036-9ab1-c95a9ada0153	Clara Herman I	12716	Calliebury	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d119-73d7-afb6-0170d7f5f900	Sonny Kautzer	37459-3302	Lake D'angelo	WA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d11a-724f-a3d1-6bfac7dd01d1	Prof. Alaina Boyer	68386	McLaughlinhaven	UT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d11b-71b0-8cc8-a147d64e7ec4	Rebeca Kautzer DDS	04603-5658	Farrellfurt	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d11c-73eb-8bb7-b15b332bca1d	Kaelyn Reynolds	53490	Deckowchester	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d11d-725a-b262-8109c00133c1	Hans Thiel V	32090	New Keshawn	OH	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d11e-73b9-8abc-6511cd78cd5e	Mrs. Linnie Walsh	05954	Mafaldaport	IL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d11f-707b-afcc-2313ce82dc99	Mr. Johnathon Hauck	00940-2983	Steuberview	LA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d12c-7091-b621-f8ec01eef8c2	Mack Miller	60154-4665	West Millie	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d12d-70c1-a99a-c6906f6e3ad2	Roger Larson MD	58666-8778	Hellerburgh	WA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d12f-700f-860e-4b9d573f1b39	Mabelle O'Keefe	28940	East Parkertown	NM	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d130-703d-abf7-46448a75120b	Ms. Brooke Osinski MD	08085-3782	Feestchester	ME	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d131-703a-a08e-69bb78cf280b	Prof. Alana Dare I	97058	Hansenshire	HI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d132-718d-8301-16063c74305e	Prof. Brown Waters V	14902-1436	Yeseniaton	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1aa-7297-a7af-05fceed4de58	Edyth Goodwin	94982-7073	North Earnestinechester	WA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ab-7087-ac4e-628f531e454a	Ferne Balistreri	31099	North Margaretfort	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ac-7089-8272-1acad3d96d1d	Prof. Kiera Witting DDS	65914	Croninshire	LA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ad-726a-8ca7-1850190a67ce	Earlene Swaniawski	02544-9317	Port Clarabelle	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ae-7165-98cb-7d3b4858b27c	Ivory Lueilwitz DDS	13962-1916	Gibsonville	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1af-733c-bcfc-b359ce800f3e	Alvis Wintheiser	91800	Weissnatmouth	OH	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b0-73ba-b650-fcbbe0f61da1	Efren Bernhard	20601-2139	Lake Adrienne	OK	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b0-73ba-b650-fcbbe148a793	Meda Wisozk DDS	43349	Gregoriatown	NH	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b1-73d9-9864-7b16a82e3d90	Marge Mraz	23505-2827	Lake Maeton	ND	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b2-705b-a8b5-5abcf7e3a6c2	Karelle King	86894-8747	Port Melody	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b3-71a8-8227-80d1f3a5737c	Rogers Rau	72856	West Mariano	NM	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b3-71a8-8227-80d1f47abf41	Ms. Catalina Anderson	64299	New Heloise	NJ	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b4-71e5-94b1-91ced6beea52	Mr. Manley Hoeger II	97317-0175	Leonorton	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b5-70bc-b240-f0fc55663bb0	Carolyne Lemke	47409	Velvatown	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b6-711c-a7c4-3d3c318203bf	Prof. Deshawn Kling	33030-6848	Christiansenland	NH	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b7-72fb-9ba0-f14d2308e953	Judd Eichmann	70294-5914	Port Dessie	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b8-7384-9316-ba20c38259e1	Desiree Swaniawski	97093-5596	East Jonatan	TN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1b9-71b7-b25e-24ac65abb059	Dulce Goyette	20146-9477	Hahnmouth	NE	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ba-7357-91bd-057d1461602f	Breana Nader	26630	Romagueraton	HI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1bb-7275-b45d-79bc9111fb3e	Jeffery Kulas III	07891-2666	Donatochester	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1bc-71a8-afcb-7f8c2caee0b3	Prof. Evie Farrell III	82927	Pacochafort	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1bd-7143-88d2-c7c6a1322016	Miss Roslyn Labadie DVM	14911	South Khalilfurt	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1be-7019-84d1-c823d4f27e0c	Llewellyn McKenzie	60219	Kihnhaven	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1bf-708d-b7ec-b7186cb0ca55	Carol Tremblay	57854-7851	Bradtketon	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c0-73df-b7bf-de620853bb17	Lillie Rempel	86394-4529	Lake Kelliville	OK	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c0-73df-b7bf-de6209106792	Kasandra Quigley Sr.	91024-0464	North Haileeborough	SC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c1-73e5-9964-926f8fd3668f	Joshuah Stehr	91001-4590	Markusview	NJ	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c2-724d-82bd-e9eb359699bb	Mazie Bogan V	63216-3634	Bentonville	MA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c3-7301-90a1-a2c7bc3db635	Winifred Romaguera PhD	56105-5165	South Kavon	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c3-7301-90a1-a2c7bca49833	Eden Bailey	80932	Lake Ariel	MI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d0-73a3-8684-3aa461fe8bce	Rhiannon Dietrich	86038-2771	Champlinberg	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d2-72b1-ae1f-fc5ad73444f6	Haskell Ortiz II	47644-1329	North Roxanemouth	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d3-7291-aa42-40faf224bf02	Abe Kautzer	84917-9904	West Gregorioport	ND	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d5-7193-bebb-7db26372dc99	Dr. Gerhard Bosco	14134-6001	Kennithberg	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d7-70a0-985d-b4068f73a3b8	Betsy Beatty	35790-2724	Port Aubreytown	WV	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d9-7235-9098-41d0aff35b41	Donato Kuphal	68521	Amiehaven	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1db-7103-835f-f5bbf6d8b347	Eliza Dare MD	62037-0600	North Lorna	LA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1dd-7189-8086-082032b9229f	Emely Bailey	01268-9121	Port Isaiah	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1df-73ab-955b-ee08d0a85c91	Stanley Hamill	09345	Homenickchester	WA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e0-72c2-9a03-1211676638a5	Zachariah Luettgen	68716	East Kaylie	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e2-7340-bd40-5851edaa5dfb	Abdul Smitham	78259-1667	New Agustinchester	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e4-7106-a0f0-4fc070178668	Jarrod Schuppe	13454	New Alyciaburgh	ID	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e6-7186-8c3b-3400886f49b9	Kassandra DuBuque	47100	Port Dora	VA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e8-734c-bdb3-3e7c32c8dd5a	Theodore Greenholt	22157-9314	New Adelbert	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ea-7213-9f9d-a02500f394bb	Grady Kunde	03828-9133	Gussieville	TN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ec-7342-a810-de4f5c32b595	Samanta Goodwin	16576	East Maximilian	ID	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ee-708b-9944-50b5affd2af7	Laisha Auer	66468	Ryanland	GA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f0-724d-a56f-2f278d7585d8	Anderson Hintz	77640	South Celialand	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f2-702c-8a7b-0cf582d08ee3	Jarrett Blanda PhD	95671-9964	Hartmannchester	ME	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f4-7152-83f3-e7b8b343182f	Josiane McGlynn	25998-4281	Corkeryhaven	OK	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f7-7278-966d-f941d0cec5fd	Mr. Alexandre Mills	10153	South Marleehaven	VA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f9-7226-b17d-cd2b98a1e35a	Raleigh Kertzmann PhD	78564-3209	Albertfort	NJ	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1fb-71b5-802e-da4137a229df	Stephon Wunsch	17369	East Lionelshire	NJ	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1fe-7111-9b0c-8d815b29bee6	Lonnie Wuckert V	68464	West Orpha	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d200-7104-950f-ce2dce92be26	Claire Kilback MD	71557-8229	North Aurelio	IA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d203-72c0-bb85-cd28fcf7bc2d	Mr. Ed Senger	96683-4911	Lake Rosendofurt	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d205-7374-9cd4-526728f87e7b	Shaun Shields V	11931	New Lolitaburgh	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d207-7360-8002-63b797a12ea5	Eladio Cruickshank	05502-3992	Coleland	ME	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d209-7397-b9c4-75f496157338	Lavon Pagac	89729-8658	Port Genemouth	ME	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20b-70d6-a1da-20124ee398bc	Dr. Coby Rodriguez	11524-5821	Bartolettistad	IN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20d-7151-9cdc-6109c857d1ae	Dr. Howard Waelchi	52836	North Jennifer	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20f-7086-9348-86b5f6bb0ca1	Janelle Wilderman	28537	Kovacekmouth	PA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d211-72bb-b76d-73c8dced5eb8	Ellsworth Boyle MD	79432	South Giuseppe	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d213-7347-a450-d8c7d978dac5	Mr. Ari Turcotte PhD	78196	South Horaceton	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d215-7398-a89d-9729ebacd63c	Dr. Mariana Wintheiser III	69995	Feilport	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d217-70e2-b377-816608fbbbc9	Korbin Walter	30094-9696	South Alda	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d219-7071-a7d9-612cb8924878	Isabella Pfeffer	13362-7816	Virgilshire	GA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21a-7242-bd07-78273d3a281d	Mr. Randall Rath	96685	West Cleo	CA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21c-738c-83ca-750855a5d7aa	Jo Ratke IV	00387	Gerardofort	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21e-7310-8460-afed5dd7899d	Mr. Ernesto Wisozk	44338-1771	Gulgowskiland	AL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d220-71a7-adbb-8b014b98cc2f	Madyson Powlowski	84998-2322	North Tressie	WV	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d222-724e-897e-2a3e943425c7	Fredrick Ankunding	54241	Cormierfurt	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d224-736d-a04f-91fd0a1a64ff	Jimmy Goodwin	59774-7235	Lake Lavinia	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d225-7213-8d2b-e57a5ae96f55	Miss Telly Monahan DDS	82822	Lyricside	WA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d227-7186-a268-e4abbb8d6108	Molly Berge I	46772	Vanstad	TX	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22a-71cf-bb1a-71ce628c0656	Alfreda Ward	11885	West Rebekaberg	OK	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22c-72d2-a1a3-dfa57fa5e0b7	Jane Hessel	17495-7393	Lindgrenmouth	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22d-71cd-8f54-0c5b24640dce	Odell Farrell	90875	Port Cortezstad	GA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22f-70a0-abba-dd0c2747df16	Dr. Camryn Murphy	53961	East Isadoreland	TX	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d231-7110-a20c-e757fc2f5c8e	Lulu Kris	05712	North Karl	CA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d232-71f4-aa90-d8a26d5ab2a2	Emilie Thiel V	42076-7841	Declanland	OH	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d234-70b6-bd11-a9b3c98ca380	Lyda Bruen	54379	Zakarytown	DC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d235-7118-96a5-184e7a0c92ce	Perry Yundt	57906	Gleasonshire	MO	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d237-71d5-b02e-59c9c6a7db59	Mr. Rogers Spinka I	83105	New Tia	AK	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d239-7130-901b-784b95a0f520	Prof. Shawn Kuhn MD	27099	Hagenesview	MN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23b-7179-9e1f-90ed5ad2d522	Marilie Gislason	77541	West Kenny	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23d-7003-8abf-8efcf27a6d60	Dortha Bernhard	50959-9292	Napoleonport	NH	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23f-7078-a71c-a56972525afb	Reynold Goldner	18038	South Herthafurt	CT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d241-729c-9d79-a11fa634deff	Prof. Ferne Kuvalis I	89002-5665	Berneiceport	DE	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d243-7320-b5e4-7e2580e3536f	Lilly Johnston DDS	74094-8339	Rogahnburgh	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d258-71e1-b5e5-94c243d7f10c	Kayla Wunsch	55488	Darrickchester	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d259-71fa-a26f-46a9fc1e134f	Jessika Dach	26074-1301	Rashawnton	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25a-70a0-926d-60e908514eee	Eladio Ullrich	73783	Marinaburgh	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25b-7207-93ba-def6431c9f5f	Bill Veum	20052-0368	North Vestaburgh	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25c-728f-a3b4-46cc8e9ce361	Rosie Okuneva	57159	West Lilian	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25d-718f-b092-d80bd1107009	Dr. Zackery Effertz V	68571-5411	North Noble	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25e-71b2-88e6-7d1d0d4fee56	Leta Cole	45525-4963	Lubowitzview	LA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25f-729b-a2ca-979492d91f0b	Vernon Ritchie	82477-2166	West Kobeport	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d260-7186-875a-15c30787bb3c	Dr. Ryan Trantow	28979	Lake Virginia	NC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d260-7186-875a-15c308514af7	Ms. Lily Rempel	28693-4405	Port Keithtown	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d261-717a-bbc0-3aab3a3363e8	Ms. Orpha O'Hara	07591	Hegmannside	NC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d262-737c-8cba-5dbc172e3b8f	Dino Zieme	50480-4694	Jaclynville	AK	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d263-736a-b8cc-de36ab1753e3	Dr. Toni Johnson	36361-5140	Jofort	ID	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d264-738e-8ff8-887812115150	Anthony Christiansen	27953-1255	West Fredyton	NC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d265-725c-995d-f7cdd1851faa	Hosea Beer DDS	47464	New Ubaldo	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d266-710d-8862-59da107dcbf1	Mr. Micah Schamberger	64295-4043	East Jewelltown	NJ	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d267-728f-b6f2-457112848c3f	Leone Schuppe Jr.	72637	South Delilah	KS	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d268-7163-b041-b8ee09094374	Edwardo Jakubowski Jr.	45736	Lake Hopeshire	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d269-7299-91ad-eb1d98fdae5f	Dayana Torp	06385-3795	West Cloyd	NM	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26a-7291-9165-4c1f3a505960	Mr. Marco Turcotte MD	74557-8225	North Ona	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26b-7014-89e8-8df65f47496d	Brigitte Glover	12687-1042	New Brisabury	HI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26c-73e6-aaf7-1b463eeba3c5	Jacinthe Jacobs DVM	87790	East Johnniebury	MN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26d-71cf-a6d0-c40a81c96ff5	Jaylen Koch	70373-3751	Camrynport	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26e-7336-8698-364553b87c46	Destini Larkin	59313-0657	Lake Meggieshire	ID	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26f-71e3-b9f4-6b9162180208	Dr. Hal Christiansen Sr.	78557	New Ignacio	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d270-71f4-90d1-40fdf21a95b7	Prof. Rebekah Runolfsdottir	30064	Port Lolita	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d270-71f4-90d1-40fdf36f5d5a	Christ Feil Jr.	58006	Murielmouth	WA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d271-7057-928e-7c08e8b54f68	Luisa O'Kon DDS	39720-0369	Smithamberg	VA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d272-704b-aa76-564cd06985d3	Ellen Green II	61776-4685	Jessikabury	MA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d273-717c-a220-5834e2794d4d	Luisa Larson	21198-7172	Timmyburgh	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27e-70d1-8b05-53c34bc53e44	Mr. Gonzalo Moore	95759	Meaganchester	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27f-735a-a606-9e6a31d78636	Willy Stamm	02934-1622	Port Grady	WY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d280-71d5-a5e1-3f5137b5bb41	Valentin Lindgren	74159-3225	Amirabury	OK	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d281-733b-ae56-98791910213c	Ms. Agustina Swaniawski	18531	North Ellsworth	AZ	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d282-72ed-be12-f10e862502b1	Bryana Blick	38677	East Royal	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d283-7104-81ef-96705edf901e	Johathan Olson PhD	89196-7111	South Aditya	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d284-736d-a4a0-ed46bf86329d	Wiley Stoltenberg	30046	West Leoneport	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d284-736d-a4a0-ed46c00cf1d5	Sasha O'Reilly II	37120-9726	Port Jordynmouth	IN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d285-73db-93ab-e12a42ecb256	Marshall Kilback	02703	West Kelsiborough	NV	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d286-7128-bdcd-ad2d6015e28d	Mr. Hank Romaguera I	93622	Taylorchester	WA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d287-70a5-a006-b1ecc5c02324	Moises Becker	70034-3339	Gibsonborough	ND	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d288-73dc-a8a7-41d008b98c8b	Tobin Fisher I	11247-8122	West Mohammed	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28a-701d-a6f4-87651a8cbc21	Juston Lindgren	28533	East Emile	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28b-72ef-9929-f08e79f55980	Miss Lucy Marquardt III	20223-3141	East Jerrold	AL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28c-70f4-afa1-768436e89f5f	Yasmeen Ebert	56985-0304	South Hilmaview	AL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28d-736a-9450-4e29767e08a8	Dr. Lela Rogahn	79553-0524	Balistreriside	NV	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28e-7223-9aaa-5b61dd469b70	Jeanie Rath	05246	Connfort	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28f-7355-90ad-6121ffa0edd2	Layla Wolff	56133	South Veda	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d290-72e5-a751-25e4ed74f28c	Annabell Gulgowski	82690	Doyleshire	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d291-732c-938a-52de7ea145b0	Mariane Mertz	13626-2164	Boganton	NM	2026-11-09 13:10:50	2026-11-09 13:10:50
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: geolocations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.geolocations (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state, created_at, updated_at) FROM stdin;
33020	25.10149700	-58.20518700	South Penelopeton	ME	2026-11-09 13:10:50	2026-11-09 13:10:50
49299	71.47138300	-50.49799400	Towneton	KS	2026-11-09 13:10:50	2026-11-09 13:10:50
60011-3432	-73.53405300	-140.19882300	Jadonside	CA	2026-11-09 13:10:50	2026-11-09 13:10:50
96933-0853	-42.89512200	103.32264400	South Stone	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
55085	-76.89740500	169.52039300	Port Rosa	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
01079-2033	33.89444000	138.10768600	Chadborough	TN	2026-11-09 13:10:50	2026-11-09 13:10:50
44901-2448	-86.54953200	-165.68788100	New Adelbertville	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
35441-5349	-30.28374900	-151.30027900	Priceland	NV	2026-11-09 13:10:50	2026-11-09 13:10:50
03975	-12.33787900	-117.23238400	Eichmannchester	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
00390-3161	67.63592900	118.77852500	Blockborough	LA	2026-11-09 13:10:50	2026-11-09 13:10:50
41684	87.12551400	14.55419800	Port Thomasstad	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
97867-6919	-43.71196200	145.27918000	Armstrongberg	NE	2026-11-09 13:10:50	2026-11-09 13:10:50
96712	-80.38579300	170.78741100	Priceside	HI	2026-11-09 13:10:50	2026-11-09 13:10:50
79730	-80.42622600	-23.75491600	East Emeraldfort	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
88376-7055	-12.00395600	-136.28908000	Port Albertstad	CA	2026-11-09 13:10:50	2026-11-09 13:10:50
79729-9796	25.34326100	-159.31843200	Ziemannstad	KS	2026-11-09 13:10:50	2026-11-09 13:10:50
33512-1041	70.97091700	-159.34055400	South April	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
09632	-3.87857500	105.09345300	East Marcellusberg	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
18408-0178	6.24586400	-143.63251300	Lavadaville	ME	2026-11-09 13:10:50	2026-11-09 13:10:50
46210-5025	31.94971800	-155.78864000	Lake Houstonton	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
39875-2689	49.36949100	-4.39305900	Jarenburgh	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
12173-6341	-57.53011900	-126.71469700	West Braedenburgh	MI	2026-11-09 13:10:50	2026-11-09 13:10:50
38804-9895	-48.66416900	6.02932200	Port Guiseppefort	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
99815-9184	-42.25513800	126.53035200	New Shawna	MO	2026-11-09 13:10:50	2026-11-09 13:10:50
43438-1872	-23.52448800	115.86170600	Janismouth	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
08589	-64.04439700	-86.25682100	Naderport	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
67389	74.41974100	-20.42362300	Berniechester	IN	2026-11-09 13:10:50	2026-11-09 13:10:50
91506	-61.46317100	5.14598400	New Margaret	NH	2026-11-09 13:10:50	2026-11-09 13:10:50
55121	1.43376800	-85.49962400	Alessiahaven	WA	2026-11-09 13:10:50	2026-11-09 13:10:50
75597-8093	-21.21932800	-91.55746600	Port Karianne	AK	2026-11-09 13:10:50	2026-11-09 13:10:50
26639-5650	55.90824500	-8.22391400	Mosciskiburgh	NC	2026-11-09 13:10:50	2026-11-09 13:10:50
21160	-16.11809400	-13.83200500	Padbergchester	NC	2026-11-09 13:10:50	2026-11-09 13:10:50
53888	36.92805200	-22.80094500	North Erik	HI	2026-11-09 13:10:50	2026-11-09 13:10:50
42540-4834	36.86246000	69.78710600	New Fae	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
19757	-46.99133300	47.42481400	Lake Ivoryborough	SC	2026-11-09 13:10:50	2026-11-09 13:10:50
38820-9240	22.57946800	63.59413000	Port Noemyland	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
28119-0814	41.41401700	88.42503100	Lake Wymanton	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
25989	-17.57912600	-124.79690700	Klinghaven	TX	2026-11-09 13:10:50	2026-11-09 13:10:50
20527	13.21599300	20.94002900	Millerfort	AZ	2026-11-09 13:10:50	2026-11-09 13:10:50
37063-1623	-59.25617600	166.81813700	Paulineberg	DE	2026-11-09 13:10:50	2026-11-09 13:10:50
10092	86.58280800	-21.21163900	East Connor	IL	2026-11-09 13:10:50	2026-11-09 13:10:50
11997-2859	-44.77253500	119.39401000	West Baronstad	PA	2026-11-09 13:10:50	2026-11-09 13:10:50
48075-5769	-8.32658900	-75.73814100	Lake Matilde	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
05257-8745	-87.86216400	-103.53060300	North Assunta	TX	2026-11-09 13:10:50	2026-11-09 13:10:50
74806	-33.39203200	-110.04192700	East Samsonstad	IL	2026-11-09 13:10:50	2026-11-09 13:10:50
49621-2028	76.75785100	28.99448700	New Chaddburgh	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
41051-0062	-10.98832700	112.95329500	East Nehashire	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
56977-4456	71.40167900	-102.64080500	Cecilemouth	SC	2026-11-09 13:10:50	2026-11-09 13:10:50
22576-3051	84.11041300	-12.94755300	Lake Montanaland	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
72132-8493	61.25790200	-162.66755100	Josefinashire	OH	2026-11-09 13:10:50	2026-11-09 13:10:50
60682	72.95184400	-112.83447700	Felicitamouth	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
49042-8824	9.38454400	-16.35431500	Lake Cletus	NJ	2026-11-09 13:10:50	2026-11-09 13:10:50
41917-6485	8.58978800	-102.14762200	New Sallie	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
60826	76.47831100	79.52039200	Arvillaview	NC	2026-11-09 13:10:50	2026-11-09 13:10:50
51048	-64.27348900	139.35423500	Lake Colin	NJ	2026-11-09 13:10:50	2026-11-09 13:10:50
62254-1498	54.01832600	-41.58821200	Blickville	TX	2026-11-09 13:10:50	2026-11-09 13:10:50
12716	-58.68667000	-52.90278100	Satterfieldtown	AL	2026-11-09 13:10:50	2026-11-09 13:10:50
37459-3302	-75.01970800	38.59541000	Alexamouth	VA	2026-11-09 13:10:50	2026-11-09 13:10:50
68386	-6.46271900	-77.10545600	Jenkinsfurt	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
04603-5658	89.78651700	-120.41370500	Toyland	GA	2026-11-09 13:10:50	2026-11-09 13:10:50
53490	-65.48239600	-93.58707100	Estellefurt	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
32090	-14.75196600	75.69240300	Savannamouth	DE	2026-11-09 13:10:50	2026-11-09 13:10:50
05954	-26.97510400	62.22050600	North Vito	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
00940-2983	19.89345200	29.63233200	South Ransomberg	KS	2026-11-09 13:10:50	2026-11-09 13:10:50
60154-4665	-11.40462300	44.29026900	Guidoview	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
58666-8778	77.37974400	42.44791300	West Mariamstad	NH	2026-11-09 13:10:50	2026-11-09 13:10:50
28940	-69.29222500	-64.35690600	Lake Jana	ID	2026-11-09 13:10:50	2026-11-09 13:10:50
08085-3782	-30.42860700	101.25955300	New Irving	NV	2026-11-09 13:10:50	2026-11-09 13:10:50
97058	-6.78072000	-107.31543800	Haskellberg	NV	2026-11-09 13:10:50	2026-11-09 13:10:50
14902-1436	85.28465300	45.10691600	Wisozkshire	KS	2026-11-09 13:10:50	2026-11-09 13:10:50
94982-7073	-8.52826500	-140.27762000	West Columbusborough	KS	2026-11-09 13:10:50	2026-11-09 13:10:50
31099	-50.83724100	22.76612200	New Jaclyn	NE	2026-11-09 13:10:50	2026-11-09 13:10:50
65914	-9.78433800	108.39864900	Lake Fritz	MO	2026-11-09 13:10:50	2026-11-09 13:10:50
02544-9317	30.70181600	-87.58403800	Simfort	CT	2026-11-09 13:10:50	2026-11-09 13:10:50
13962-1916	64.21427500	-8.30191500	West Marilyneshire	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
91800	-26.69132800	172.72397000	Vernhaven	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
20601-2139	78.75957100	173.36790200	North Reecestad	OK	2026-11-09 13:10:50	2026-11-09 13:10:50
43349	80.57540000	162.69836600	Kossborough	OK	2026-11-09 13:10:50	2026-11-09 13:10:50
23505-2827	59.45342700	-167.29929200	New Edwardo	KS	2026-11-09 13:10:50	2026-11-09 13:10:50
86894-8747	89.30668000	-112.14209600	Pacochaberg	MN	2026-11-09 13:10:50	2026-11-09 13:10:50
72856	-58.85665500	36.30320800	West Tanner	UT	2026-11-09 13:10:50	2026-11-09 13:10:50
64299	-75.61488500	-8.86276300	Beattyberg	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
97317-0175	-36.34041600	-16.08373400	Briahaven	AK	2026-11-09 13:10:50	2026-11-09 13:10:50
47409	-32.19207600	-90.83350800	East Hallie	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
33030-6848	-13.45364800	-19.35458000	South Jalenmouth	MI	2026-11-09 13:10:50	2026-11-09 13:10:50
70294-5914	76.49700500	68.99532800	Ornside	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
97093-5596	-26.15293500	-85.92085200	Evachester	GA	2026-11-09 13:10:50	2026-11-09 13:10:50
20146-9477	77.02513500	48.94645500	Port Fabianchester	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
26630	-30.29123900	-17.55034700	East Uriel	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
07891-2666	-3.32488600	147.75465100	Serenafurt	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
82927	-62.17197900	-87.23440500	Reynoldsfort	KS	2026-11-09 13:10:50	2026-11-09 13:10:50
14911	-17.56931200	-171.16242600	Port Royal	ID	2026-11-09 13:10:50	2026-11-09 13:10:50
60219	-2.37061800	-0.83237500	Zoilabury	NM	2026-11-09 13:10:50	2026-11-09 13:10:50
57854-7851	46.63184200	-66.43822600	South Ardellashire	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
86394-4529	-42.04778300	-79.42610100	West Jerroldfort	CA	2026-11-09 13:10:50	2026-11-09 13:10:50
91024-0464	27.13992200	-167.93768000	McLaughlinbury	ND	2026-11-09 13:10:50	2026-11-09 13:10:50
91001-4590	-62.21470000	-68.52718400	Averyburgh	ID	2026-11-09 13:10:50	2026-11-09 13:10:50
63216-3634	-18.91999400	-103.84155000	East Demetris	PA	2026-11-09 13:10:50	2026-11-09 13:10:50
56105-5165	71.72652700	16.32681300	Lafayetteborough	NH	2026-11-09 13:10:50	2026-11-09 13:10:50
80932	9.69383100	-1.20427200	Pattown	ID	2026-11-09 13:10:50	2026-11-09 13:10:50
86038-2771	-58.05682800	142.25495500	Lake Savanah	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
47644-1329	31.64078700	144.19405700	New Alda	UT	2026-11-09 13:10:50	2026-11-09 13:10:50
84917-9904	82.33024600	-127.67152800	Port Antonio	NE	2026-11-09 13:10:50	2026-11-09 13:10:50
14134-6001	-0.99863100	55.63013900	Flossieton	NH	2026-11-09 13:10:50	2026-11-09 13:10:50
35790-2724	10.39066800	-60.52110300	Laishafurt	HI	2026-11-09 13:10:50	2026-11-09 13:10:50
68521	-82.89355400	155.86199800	Lake Arlie	MA	2026-11-09 13:10:50	2026-11-09 13:10:50
62037-0600	-51.41809400	-113.39898100	Port Beth	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
01268-9121	-12.87055300	-120.75335200	New Mustafa	IL	2026-11-09 13:10:50	2026-11-09 13:10:50
09345	38.87212600	83.35513500	Arvidchester	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
68716	-16.33093600	-1.98582600	Gleasonberg	GA	2026-11-09 13:10:50	2026-11-09 13:10:50
78259-1667	-76.03425300	153.07771600	Port Lorafort	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
13454	17.69750500	-6.23752200	New Buddy	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
47100	-68.17537800	51.99162500	Port Newton	AZ	2026-11-09 13:10:50	2026-11-09 13:10:50
22157-9314	-68.73013300	-76.90598000	New Jaidenbury	MO	2026-11-09 13:10:50	2026-11-09 13:10:50
03828-9133	-62.73071500	-71.18864900	Abbigailtown	TX	2026-11-09 13:10:50	2026-11-09 13:10:50
16576	27.73165900	-34.57803700	East Virgilberg	NH	2026-11-09 13:10:50	2026-11-09 13:10:50
66468	46.97754900	133.81018600	Andreanefurt	IA	2026-11-09 13:10:50	2026-11-09 13:10:50
77640	-50.11492000	-147.00206800	New Joshua	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
95671-9964	-55.64353900	-159.66117500	Port Aubreeside	NE	2026-11-09 13:10:50	2026-11-09 13:10:50
25998-4281	54.42693400	60.74113200	North Mikestad	AL	2026-11-09 13:10:50	2026-11-09 13:10:50
10153	44.73484400	55.32369100	Kutchchester	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
78564-3209	57.43540900	-113.49069900	Ullrichchester	ME	2026-11-09 13:10:50	2026-11-09 13:10:50
17369	47.63780600	147.02848500	Port Joanamouth	NV	2026-11-09 13:10:50	2026-11-09 13:10:50
68464	-10.61830800	77.25748800	North Dalefurt	ME	2026-11-09 13:10:50	2026-11-09 13:10:50
71557-8229	3.76602900	14.95566200	South Camren	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
96683-4911	25.89067800	-134.15318000	Lake Zionfurt	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
11931	-86.62011600	34.84841800	Lednerberg	NJ	2026-11-09 13:10:50	2026-11-09 13:10:50
05502-3992	-20.44152700	-23.43192200	Olsonfort	NM	2026-11-09 13:10:50	2026-11-09 13:10:50
89729-8658	-78.65890700	119.00224200	North Heidishire	DE	2026-11-09 13:10:50	2026-11-09 13:10:50
11524-5821	75.91461800	-82.92965100	Tessieville	SC	2026-11-09 13:10:50	2026-11-09 13:10:50
52836	35.63000800	99.59878400	West Dalehaven	DE	2026-11-09 13:10:50	2026-11-09 13:10:50
28537	-2.82110200	-139.44030300	New Vada	TN	2026-11-09 13:10:50	2026-11-09 13:10:50
79432	-12.65007000	91.10508800	West Nadiaview	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
78196	-62.34102500	129.74353100	North Vidaville	HI	2026-11-09 13:10:50	2026-11-09 13:10:50
69995	-39.64653700	-96.59107500	Port Meaganland	WV	2026-11-09 13:10:50	2026-11-09 13:10:50
30094-9696	-71.83281700	-59.53858600	East Jeffery	PA	2026-11-09 13:10:50	2026-11-09 13:10:50
13362-7816	75.12747300	178.25886000	Naomistad	UT	2026-11-09 13:10:50	2026-11-09 13:10:50
96685	-73.83921300	138.50902600	Lake Birdieshire	NM	2026-11-09 13:10:50	2026-11-09 13:10:50
00387	-59.56691600	-35.56605300	New Christiana	CT	2026-11-09 13:10:50	2026-11-09 13:10:50
44338-1771	-60.34678400	172.58318900	Mosciskimouth	IL	2026-11-09 13:10:50	2026-11-09 13:10:50
84998-2322	-18.00993600	157.40530400	Wisozkview	DE	2026-11-09 13:10:50	2026-11-09 13:10:50
54241	-39.23087500	-14.44637500	Gusikowskifurt	IL	2026-11-09 13:10:50	2026-11-09 13:10:50
59774-7235	84.82347500	-0.18235700	Hoegerville	CT	2026-11-09 13:10:50	2026-11-09 13:10:50
82822	-67.93776700	-154.01703300	Bethland	MA	2026-11-09 13:10:50	2026-11-09 13:10:50
46772	56.80326500	121.55934700	Wehnerland	IN	2026-11-09 13:10:50	2026-11-09 13:10:50
11885	73.18477600	-12.89780600	South Mavisfurt	HI	2026-11-09 13:10:50	2026-11-09 13:10:50
17495-7393	44.40806600	-71.59016500	Port Van	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
90875	-67.61319700	136.40994600	Faheyville	MA	2026-11-09 13:10:50	2026-11-09 13:10:50
53961	84.58653200	-118.77051700	Landenton	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
05712	19.84210500	-169.31600600	Ronaldohaven	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
42076-7841	51.06643900	65.86251600	Beverlyton	AL	2026-11-09 13:10:50	2026-11-09 13:10:50
54379	35.40282300	5.74470000	Mosciskibury	OK	2026-11-09 13:10:50	2026-11-09 13:10:50
57906	-12.82483800	-15.49204100	Port Ervin	AZ	2026-11-09 13:10:50	2026-11-09 13:10:50
83105	-40.20751900	-8.44234700	Westmouth	NE	2026-11-09 13:10:50	2026-11-09 13:10:50
27099	-40.58904700	22.60507000	West Yessenia	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
77541	-32.99018100	35.34612700	Port Geostad	IA	2026-11-09 13:10:50	2026-11-09 13:10:50
50959-9292	64.42149600	98.40518900	Lake Orionstad	NE	2026-11-09 13:10:50	2026-11-09 13:10:50
18038	43.37887000	-93.36944700	West Gustbury	NJ	2026-11-09 13:10:50	2026-11-09 13:10:50
89002-5665	-17.86093500	24.76776900	New Raoulshire	GA	2026-11-09 13:10:50	2026-11-09 13:10:50
74094-8339	-23.31085200	84.44432800	North Myrtisshire	MI	2026-11-09 13:10:50	2026-11-09 13:10:50
55488	57.25544000	156.69941100	Montyhaven	GA	2026-11-09 13:10:50	2026-11-09 13:10:50
26074-1301	-43.56403300	69.88729900	Strackechester	NH	2026-11-09 13:10:50	2026-11-09 13:10:50
73783	88.53558600	131.32928900	Lake Richmondhaven	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
20052-0368	-15.52183600	-42.33057400	Boydview	MI	2026-11-09 13:10:50	2026-11-09 13:10:50
57159	-19.96124700	107.08002500	Zorabury	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
68571-5411	4.39930000	15.68941700	Annabelleborough	DE	2026-11-09 13:10:50	2026-11-09 13:10:50
45525-4963	-4.58467300	93.20172300	Port Markhaven	NV	2026-11-09 13:10:50	2026-11-09 13:10:50
82477-2166	-24.19183100	100.06626400	South Jamelville	ID	2026-11-09 13:10:50	2026-11-09 13:10:50
28979	15.90972000	46.65388200	Macieborough	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
28693-4405	-48.64395400	137.95910300	North Sebastian	MO	2026-11-09 13:10:50	2026-11-09 13:10:50
07591	-72.41053800	27.55401300	North Katarina	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
50480-4694	27.33431000	91.68731400	Stromanville	DE	2026-11-09 13:10:50	2026-11-09 13:10:50
36361-5140	-26.98476400	1.70178300	Ryleighborough	TX	2026-11-09 13:10:50	2026-11-09 13:10:50
27953-1255	52.54188400	-98.00694400	North Rylan	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
47464	-7.14959100	-155.99896100	North Lupechester	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
64295-4043	-67.72817000	-141.75500700	South Reginaldhaven	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
72637	-54.27626800	76.23791900	Blockport	WV	2026-11-09 13:10:50	2026-11-09 13:10:50
45736	50.98822300	146.10807700	Dachside	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
06385-3795	-20.54269900	40.77984600	Lake Astrid	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
74557-8225	36.20076500	-90.46484700	Hamillstad	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
12687-1042	12.85980800	13.97912100	Port Hans	SC	2026-11-09 13:10:50	2026-11-09 13:10:50
87790	10.23890800	94.40442800	South Evangeline	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
70373-3751	-11.20332000	2.68279300	Autumnfurt	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
59313-0657	-71.16765000	158.68650300	Nasirhaven	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
78557	72.93177200	-61.41082900	Hegmannton	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
30064	37.68005800	-100.00084100	North Hectorstad	AZ	2026-11-09 13:10:50	2026-11-09 13:10:50
58006	26.62711700	-11.21073600	Port Devyn	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
39720-0369	31.69576400	157.46361200	Bashirianborough	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
61776-4685	25.21147300	-151.30740400	Hermanntown	NM	2026-11-09 13:10:50	2026-11-09 13:10:50
21198-7172	-0.11607900	2.17445300	Murrayfort	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
95759	-64.38511900	-62.94477200	Johnathonview	CT	2026-11-09 13:10:50	2026-11-09 13:10:50
02934-1622	83.23275600	-136.01785100	West Rogers	ND	2026-11-09 13:10:50	2026-11-09 13:10:50
74159-3225	25.30941600	149.09758200	Wymanberg	CT	2026-11-09 13:10:50	2026-11-09 13:10:50
18531	4.02820400	-70.14262500	Littelville	TN	2026-11-09 13:10:50	2026-11-09 13:10:50
38677	-10.50628400	14.48991800	Lake Cornell	WI	2026-11-09 13:10:50	2026-11-09 13:10:50
89196-7111	-42.06055500	29.66254100	Lynchberg	WA	2026-11-09 13:10:50	2026-11-09 13:10:50
30046	66.86265500	-30.81333100	Daneville	MI	2026-11-09 13:10:50	2026-11-09 13:10:50
37120-9726	3.23606700	-154.39109800	Hayesburgh	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
02703	53.89723200	-75.17097200	Kylafurt	NV	2026-11-09 13:10:50	2026-11-09 13:10:50
93622	-29.66204900	-25.43712200	Stephanborough	GA	2026-11-09 13:10:50	2026-11-09 13:10:50
70034-3339	13.82611300	-168.15030000	Dixietown	AK	2026-11-09 13:10:50	2026-11-09 13:10:50
11247-8122	2.12852300	109.66883700	Medhurstfurt	AL	2026-11-09 13:10:50	2026-11-09 13:10:50
28533	60.45748900	40.70120300	Port Novellaton	GA	2026-11-09 13:10:50	2026-11-09 13:10:50
20223-3141	9.15107900	-69.80649400	East Muriel	SC	2026-11-09 13:10:50	2026-11-09 13:10:50
56985-0304	-26.14382900	19.27173200	Collinshaven	ME	2026-11-09 13:10:50	2026-11-09 13:10:50
79553-0524	35.90685300	-94.58138200	Kihnville	SC	2026-11-09 13:10:50	2026-11-09 13:10:50
05246	6.35912400	-15.73210500	Port Edgar	LA	2026-11-09 13:10:50	2026-11-09 13:10:50
56133	20.45036500	84.49474900	New Adalberto	SC	2026-11-09 13:10:50	2026-11-09 13:10:50
82690	31.02229300	-155.26264400	Noblemouth	MS	2026-11-09 13:10:50	2026-11-09 13:10:50
13626-2164	-66.35106600	-74.82969500	East Rudystad	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2024_01_01_000000_create_passkeys_table	1
5	2025_08_14_170933_add_two_factor_columns_to_users_table	1
6	2026_01_01_000000_create_geolocations_table	1
7	2026_01_01_000001_create_customers_table	1
8	2026_01_01_000002_create_sellers_table	1
9	2026_01_01_000003_create_product_category_translations_table	1
10	2026_01_01_000004_create_products_table	1
11	2026_01_01_000005_create_orders_table	1
12	2026_01_01_000006_create_order_items_table	1
13	2026_01_01_000007_create_order_payments_table	1
14	2026_01_01_000008_create_order_reviews_table	1
15	2026_01_02_000000_add_indexes_for_performance	2
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value, created_at, updated_at) FROM stdin;
01a1c06e-d245-73eb-9416-98acf67ff168	01a1c06e-d1d0-73a3-8684-3aa4628c88c9	3	01a1c06e-d1d1-7168-a5fd-5ffd11f8cfd8	01a1c06e-d1d1-7168-a5fd-5ffd127b08b4	2026-11-22 00:57:39	139.61	8.06	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d246-71e3-b0d2-2335d42c9335	01a1c06e-d1d2-72b1-ae1f-fc5ad7f44884	5	01a1c06e-d1d2-72b1-ae1f-fc5ad8a38663	01a1c06e-d1d3-7291-aa42-40faf1951bcb	2026-11-15 04:25:31	330.80	7.62	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d246-71e3-b0d2-2335d5005840	01a1c06e-d1d3-7291-aa42-40faf25b12b2	5	01a1c06e-d1d4-72f0-8b34-7a5b7f939e4c	01a1c06e-d1d5-7193-bebb-7db2628c7d8e	2026-12-05 19:08:27	106.11	39.72	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d247-7256-8bae-ab0275d0c796	01a1c06e-d1d6-70f2-90db-9bc8e8e5071c	4	01a1c06e-d1d6-70f2-90db-9bc8e9c02d97	01a1c06e-d1d7-70a0-985d-b4068f298dc8	2026-11-29 18:13:56	401.10	39.39	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d247-7256-8bae-ab0275efe28f	01a1c06e-d1d8-718b-bbf0-edd6b3f5f9cf	3	01a1c06e-d1d8-718b-bbf0-edd6b4461fc6	01a1c06e-d1d9-7235-9098-41d0af2a40fc	2026-11-17 15:26:40	176.51	21.73	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d247-7256-8bae-ab02765a9af6	01a1c06e-d1da-71b4-bafd-45e629b0b779	4	01a1c06e-d1da-71b4-bafd-45e629f3c9e1	01a1c06e-d1db-7103-835f-f5bbf62d31a6	2026-11-14 08:40:26	479.65	37.92	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d248-7353-bd0d-f95ee94c5fcf	01a1c06e-d1db-7103-835f-f5bbf73bb495	1	01a1c06e-d1dc-70e3-b8ce-9b87bbd972cd	01a1c06e-d1dc-70e3-b8ce-9b87bc7213b0	2026-12-07 15:47:05	346.45	23.31	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d248-7353-bd0d-f95ee94dc2a8	01a1c06e-d1dd-7189-8086-082032c975d8	3	01a1c06e-d1de-7348-9d9f-4ec550f75bdc	01a1c06e-d1de-7348-9d9f-4ec551000edf	2026-11-24 17:38:36	425.66	49.67	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d248-7353-bd0d-f95ee9649b27	01a1c06e-d1df-73ab-955b-ee08d13a370d	5	01a1c06e-d1df-73ab-955b-ee08d18a251c	01a1c06e-d1e0-72c2-9a03-121166cf5994	2026-11-26 21:03:29	241.68	16.43	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d249-7180-a798-84541f6316f9	01a1c06e-d1e1-7305-801b-8383052e381f	3	01a1c06e-d1e1-7305-801b-838305cd3101	01a1c06e-d1e2-7340-bd40-5851ed3ac41c	2026-12-04 15:43:25	202.45	35.60	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d249-7180-a798-84541ff7410f	01a1c06e-d1e3-719a-9d7d-b389b030aaae	3	01a1c06e-d1e3-719a-9d7d-b389b0942b5b	01a1c06e-d1e4-7106-a0f0-4fc06f935b43	2026-11-23 05:02:04	454.51	5.22	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d249-7180-a798-8454205dcbd5	01a1c06e-d1e4-7106-a0f0-4fc070c08404	1	01a1c06e-d1e5-73d7-b2df-42529fae067c	01a1c06e-d1e5-73d7-b2df-4252a0a82b1e	2026-12-04 23:00:07	498.63	35.32	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d249-7180-a798-845420aaa15c	01a1c06e-d1e6-7186-8c3b-340088f8f03c	3	01a1c06e-d1e7-7102-a12a-7cb9d9729fe2	01a1c06e-d1e7-7102-a12a-7cb9da45b800	2026-11-20 09:55:23	238.93	39.41	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24a-7315-af6c-fdf20b0c4301	01a1c06e-d1e8-734c-bdb3-3e7c33a36a13	5	01a1c06e-d1e9-72cf-8a87-0f1fbf74b744	01a1c06e-d1e9-72cf-8a87-0f1fc022abf3	2026-11-10 18:11:14	371.86	12.28	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24a-7315-af6c-fdf20b8e4960	01a1c06e-d1ea-7213-9f9d-a025011c9a06	3	01a1c06e-d1eb-7361-9e83-8cf4295539c9	01a1c06e-d1eb-7361-9e83-8cf429d99a95	2026-11-20 09:11:54	477.02	42.34	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24a-7315-af6c-fdf20bda4f1b	01a1c06e-d1ec-7342-a810-de4f5c80e983	2	01a1c06e-d1ed-7252-9e4c-5605b5892bfa	01a1c06e-d1ed-7252-9e4c-5605b60fff96	2026-12-04 23:05:58	255.68	24.00	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24a-7315-af6c-fdf20c08de1a	01a1c06e-d1ee-708b-9944-50b5b0b6bdd0	3	01a1c06e-d1ef-7342-9b12-d87b51295230	01a1c06e-d1ef-7342-9b12-d87b5223bbb2	2026-11-19 06:50:34	141.47	21.70	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24b-715a-9ef0-68db7e85a5fe	01a1c06e-d1f0-724d-a56f-2f278dd25c05	3	01a1c06e-d1f1-73d5-b04e-0be279dc84f3	01a1c06e-d1f1-73d5-b04e-0be27a7a814e	2026-11-30 03:23:12	107.43	5.03	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24b-715a-9ef0-68db7f549ca0	01a1c06e-d1f2-702c-8a7b-0cf5839456ba	3	01a1c06e-d1f3-724f-af4c-4b2da2f7bd64	01a1c06e-d1f3-724f-af4c-4b2da315fb98	2026-12-05 05:36:12	292.86	11.41	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24c-71e6-85da-fc3b0d791023	01a1c06e-d1f4-7152-83f3-e7b8b3a77524	1	01a1c06e-d1f5-71c6-800c-f1afab348244	01a1c06e-d1f6-71e3-a583-50514443e926	2026-11-27 21:49:25	95.30	26.75	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24c-71e6-85da-fc3b0d98ffb2	01a1c06e-d1f7-7278-966d-f941d1ae1acf	4	01a1c06e-d1f8-718d-99e3-f4890e126f1c	01a1c06e-d1f8-718d-99e3-f4890ea7fe16	2026-11-23 12:36:25	247.47	5.04	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24c-71e6-85da-fc3b0e7d9747	01a1c06e-d1f9-7226-b17d-cd2b995970ad	1	01a1c06e-d1fa-7035-8551-e4c8af2d6515	01a1c06e-d1fa-7035-8551-e4c8affabccd	2026-11-27 03:01:10	436.08	38.05	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24c-71e6-85da-fc3b0eb2ad1d	01a1c06e-d1fb-71b5-802e-da413863a404	5	01a1c06e-d1fc-71d5-a0db-8c69206f017a	01a1c06e-d1fd-731f-96a7-38ca49ad00b7	2026-12-08 21:58:01	231.16	38.00	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24d-71c5-a104-62ce7065b102	01a1c06e-d1fe-7111-9b0c-8d815bfbb81e	5	01a1c06e-d1ff-719e-a955-4b9f19ba8a1d	01a1c06e-d1ff-719e-a955-4b9f1a4145ab	2026-11-19 08:37:59	269.13	43.21	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24d-71c5-a104-62ce70e3c420	01a1c06e-d201-705d-98c8-85188cc28c8c	2	01a1c06e-d201-705d-98c8-85188d5cf8c7	01a1c06e-d202-712c-b1ff-fac0fab36d19	2026-11-14 13:41:28	40.20	32.92	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24d-71c5-a104-62ce7160549d	01a1c06e-d203-72c0-bb85-cd28fd7aae7a	4	01a1c06e-d204-7384-99c3-a534437e1760	01a1c06e-d204-7384-99c3-a534441de562	2026-12-04 02:46:42	435.96	19.29	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24d-71c5-a104-62ce722c413d	01a1c06e-d206-7165-a460-84a7006b3ba0	3	01a1c06e-d206-7165-a460-84a7008d73db	01a1c06e-d207-7360-8002-63b797580dbd	2026-11-29 23:49:22	274.84	46.99	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24d-71c5-a104-62ce72b97869	01a1c06e-d208-70fb-95b4-bd27f7ecbcb4	1	01a1c06e-d208-70fb-95b4-bd27f8d00091	01a1c06e-d209-7397-b9c4-75f495577b54	2026-11-16 11:29:33	193.13	49.79	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24e-725a-b8df-b795f00a213d	01a1c06e-d20a-7075-ad6b-099400b51c63	3	01a1c06e-d20a-7075-ad6b-09940125a67b	01a1c06e-d20b-70d6-a1da-20124e626e09	2026-11-26 06:52:07	260.80	38.60	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24e-725a-b8df-b795f0a48011	01a1c06e-d20c-70f0-8127-476eebfb53ef	5	01a1c06e-d20c-70f0-8127-476eec064153	01a1c06e-d20c-70f0-8127-476eecef1631	2026-11-19 07:00:44	236.52	16.41	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24e-725a-b8df-b795f14f21d9	01a1c06e-d20e-7036-85e5-b7e187e9ba9c	3	01a1c06e-d20e-7036-85e5-b7e1880b2b53	01a1c06e-d20f-7086-9348-86b5f6091764	2026-11-11 18:29:54	312.40	41.70	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24e-725a-b8df-b795f1e68bc7	01a1c06e-d210-704b-990a-004d16a5f065	1	01a1c06e-d210-704b-990a-004d17094e38	01a1c06e-d211-72bb-b76d-73c8dc0c0f09	2026-12-06 18:14:58	16.12	33.79	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24f-70c7-a79f-9040946182f1	01a1c06e-d211-72bb-b76d-73c8dd12b333	5	01a1c06e-d212-71dc-b48e-87f7d0bc287f	01a1c06e-d212-71dc-b48e-87f7d176853f	2026-12-08 07:42:50	272.22	47.22	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24f-70c7-a79f-904094b71c49	01a1c06e-d213-7347-a450-d8c7d9b48901	1	01a1c06e-d214-717b-a71a-8505ceb74bb3	01a1c06e-d214-717b-a71a-8505cfa8c51c	2026-11-25 01:20:04	17.43	26.35	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d24f-70c7-a79f-904095af56e5	01a1c06e-d215-7398-a89d-9729ebd042c9	3	01a1c06e-d216-72ef-b718-13b8b62e884a	01a1c06e-d216-72ef-b718-13b8b6bb934b	2026-11-23 14:15:36	330.79	22.30	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d250-7089-b08f-c3dbe09d809a	01a1c06e-d217-70e2-b377-81660911ed4f	1	01a1c06e-d218-70bb-b72d-3e01223f9ea7	01a1c06e-d218-70bb-b72d-3e0122e9a765	2026-11-30 20:48:15	215.42	48.93	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d250-7089-b08f-c3dbe19d26e7	01a1c06e-d219-7071-a7d9-612cb9685e23	1	01a1c06e-d219-7071-a7d9-612cb9a5c3a7	01a1c06e-d21a-7242-bd07-78273cd700dc	2026-12-08 22:32:49	314.89	6.02	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d250-7089-b08f-c3dbe267826f	01a1c06e-d21b-70ba-8d50-71520c99c0ac	5	01a1c06e-d21b-70ba-8d50-71520cc08e09	01a1c06e-d21b-70ba-8d50-71520cd188ee	2026-12-09 10:19:06	94.36	5.87	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d250-7089-b08f-c3dbe3296b21	01a1c06e-d21c-738c-83ca-750856719c95	2	01a1c06e-d21d-7205-86d4-7ecce918d5e3	01a1c06e-d21d-7205-86d4-7ecce953ad1d	2026-11-11 04:02:03	72.30	5.49	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d250-7089-b08f-c3dbe33e6de1	01a1c06e-d21e-7310-8460-afed5e5fed3b	2	01a1c06e-d21f-71d9-a5b5-f1cf2b5d9e14	01a1c06e-d21f-71d9-a5b5-f1cf2b7bdd38	2026-11-19 21:25:35	106.29	28.11	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d251-7265-99c0-6c1147c8805e	01a1c06e-d220-71a7-adbb-8b014beb9a2d	2	01a1c06e-d221-7339-a020-78aef056285e	01a1c06e-d221-7339-a020-78aef0a39714	2026-12-01 23:19:59	34.79	8.47	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d251-7265-99c0-6c1147e6800d	01a1c06e-d222-724e-897e-2a3e94d5c49b	3	01a1c06e-d223-7370-8314-c5d117798ce8	01a1c06e-d223-7370-8314-c5d117e9565c	2026-12-07 22:49:37	149.77	10.05	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d251-7265-99c0-6c1147fa579c	01a1c06e-d224-736d-a04f-91fd0ab8b65f	1	01a1c06e-d225-7213-8d2b-e57a5a5f004b	01a1c06e-d225-7213-8d2b-e57a5ac19fe4	2026-11-27 12:22:58	175.44	35.41	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d251-7265-99c0-6c1148d2c16a	01a1c06e-d226-711d-986b-fd70f3a2a543	5	01a1c06e-d226-711d-986b-fd70f3ea5480	01a1c06e-d227-7186-a268-e4abbb7c41f6	2026-11-30 08:16:21	60.77	40.74	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d252-7207-86e7-d501e3e9ab27	01a1c06e-d228-72a4-abfe-4d3229118d0c	4	01a1c06e-d228-72a4-abfe-4d32294ece43	01a1c06e-d229-71c7-883d-9cf884c80a6b	2026-12-04 03:33:23	157.94	34.56	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d252-7207-86e7-d501e3ee5fec	01a1c06e-d22a-71cf-bb1a-71ce63700a19	4	01a1c06e-d22b-7360-8f55-2c678725ccf1	01a1c06e-d22b-7360-8f55-2c6787f7383c	2026-12-06 16:32:27	409.63	34.33	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d252-7207-86e7-d501e4d7cce2	01a1c06e-d22c-72d2-a1a3-dfa5805c6695	5	01a1c06e-d22c-72d2-a1a3-dfa5811f625a	01a1c06e-d22d-71cd-8f54-0c5b24538e70	2026-11-14 03:18:48	185.61	38.93	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d252-7207-86e7-d501e55b9df0	01a1c06e-d22e-7294-8815-c29cb4f03296	2	01a1c06e-d22e-7294-8815-c29cb5e88478	01a1c06e-d22e-7294-8815-c29cb5fc4a37	2026-12-05 05:20:19	60.42	6.33	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d252-7207-86e7-d501e6081d30	01a1c06e-d22f-70a0-abba-dd0c27e426d8	2	01a1c06e-d230-73d1-9537-0c5a4b3b05a8	01a1c06e-d230-73d1-9537-0c5a4b927fbb	2026-11-23 03:51:53	107.37	28.57	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d253-7108-bd04-772c37e82fcf	01a1c06e-d231-7110-a20c-e757fcf5e264	1	01a1c06e-d231-7110-a20c-e757fd6ae0e2	01a1c06e-d231-7110-a20c-e757fdd8b97b	2026-11-24 17:32:13	242.94	6.43	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d253-7108-bd04-772c38971e42	01a1c06e-d232-71f4-aa90-d8a26d9d8502	5	01a1c06e-d233-70d9-a4d7-24b9ab6d4e6a	01a1c06e-d233-70d9-a4d7-24b9abf9766b	2026-12-08 07:20:21	77.41	24.07	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d253-7108-bd04-772c398be627	01a1c06e-d234-70b6-bd11-a9b3ca1edaab	3	01a1c06e-d234-70b6-bd11-a9b3cab59f20	01a1c06e-d235-7118-96a5-184e79ad5dd4	2026-11-19 11:42:17	387.33	21.01	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d253-7108-bd04-772c399bf393	01a1c06e-d236-72ca-8e67-e3a24d5ae4b4	5	01a1c06e-d236-72ca-8e67-e3a24daba557	01a1c06e-d236-72ca-8e67-e3a24e8d2314	2026-11-14 22:30:55	34.24	47.61	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d254-7178-983c-cb75a896d792	01a1c06e-d238-734b-8a73-521ac5c748b2	4	01a1c06e-d238-734b-8a73-521ac6530829	01a1c06e-d239-7130-901b-784b956664a6	2026-11-13 13:49:32	194.28	48.65	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d254-7178-983c-cb75a8c2e6e1	01a1c06e-d23a-729e-8a88-f8b8bfb71483	2	01a1c06e-d23a-729e-8a88-f8b8c07df4a2	01a1c06e-d23b-7179-9e1f-90ed5a18935c	2026-11-19 06:05:28	312.12	22.38	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d254-7178-983c-cb75a8fba1fa	01a1c06e-d23c-73b2-a16f-c97a5e018dbd	4	01a1c06e-d23c-73b2-a16f-c97a5edbb6e8	01a1c06e-d23c-73b2-a16f-c97a5f30a141	2026-11-25 12:20:04	131.50	26.86	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d254-7178-983c-cb75a963419f	01a1c06e-d23e-724e-92b2-6c6e683ea955	4	01a1c06e-d23e-724e-92b2-6c6e685bd76a	01a1c06e-d23f-7078-a71c-a569719ca755	2026-11-26 03:38:18	435.07	37.87	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d255-7280-8a08-60facf31e30d	01a1c06e-d240-7011-ac53-c771df8fa0e6	2	01a1c06e-d240-7011-ac53-c771e014b052	01a1c06e-d241-729c-9d79-a11fa5d865e2	2026-11-17 17:26:59	323.11	48.24	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d255-7280-8a08-60facf8ffbde	01a1c06e-d242-71f9-930f-3fb88ae61a30	1	01a1c06e-d242-71f9-930f-3fb88ba7fac3	01a1c06e-d242-71f9-930f-3fb88c7c27a7	2026-11-16 06:44:51	73.76	35.50	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d256-71cc-8290-b415b2b99459	01a1c06e-d244-726e-b9a5-11fce0335d52	1	01a1c06e-d244-726e-b9a5-11fce0adce3b	01a1c06e-d244-726e-b9a5-11fce170f8f2	2026-11-26 12:06:06	28.54	29.25	2026-11-09 13:10:50	2026-11-09 13:10:50
\.


--
-- Data for Name: order_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_payments (id, order_id, payment_sequential, payment_type, payment_installments, payment_value, created_at, updated_at) FROM stdin;
01a1c06e-d274-7302-9565-dc88f105710b	01a1c06e-d258-71e1-b5e5-94c244d66e73	2	voucher	2	20.99	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d276-710f-b5b6-6ded466e7235	01a1c06e-d25a-70a0-926d-60e90757caa0	2	credit_card	5	998.14	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d276-710f-b5b6-6ded47150fa0	01a1c06e-d25b-7207-93ba-def6422a13af	1	boleto	5	87.97	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d277-70f0-8421-199d5d318373	01a1c06e-d25b-7207-93ba-def6436e139e	2	boleto	4	16.48	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d277-70f0-8421-199d5de5b32f	01a1c06e-d25c-728f-a3b4-46cc8f7c83e6	1	boleto	6	257.61	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d277-70f0-8421-199d5e328259	01a1c06e-d25d-718f-b092-d80bd1a29f49	2	debit_card	1	850.10	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d277-70f0-8421-199d5e9759b4	01a1c06e-d25e-71b2-88e6-7d1d0e402789	2	voucher	12	298.90	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d278-716d-b907-6875c6309a23	01a1c06e-d25f-729b-a2ca-979492ef4754	2	debit_card	9	787.22	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d278-716d-b907-6875c6746a0e	01a1c06e-d260-7186-875a-15c307d44590	2	boleto	7	478.17	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d278-716d-b907-6875c7519e52	01a1c06e-d261-717a-bbc0-3aab3a32f7a1	2	credit_card	6	661.03	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d278-716d-b907-6875c7e0fa49	01a1c06e-d262-737c-8cba-5dbc172d4bd5	3	credit_card	11	848.49	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d278-716d-b907-6875c86b3518	01a1c06e-d262-737c-8cba-5dbc17dcb220	1	debit_card	7	697.28	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d279-71a5-9e45-a36694b53c9b	01a1c06e-d263-736a-b8cc-de36ab17f935	2	boleto	9	968.87	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d279-71a5-9e45-a3669553be2d	01a1c06e-d264-738e-8ff8-88781289bca6	1	credit_card	9	660.28	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d279-71a5-9e45-a3669585e7d6	01a1c06e-d266-710d-8862-59da1008739f	3	credit_card	7	434.87	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d279-71a5-9e45-a36695cd4373	01a1c06e-d267-728f-b6f2-45711214e1ff	2	boleto	2	204.65	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27a-722d-8672-575f405e54a7	01a1c06e-d268-7163-b041-b8ee080e2a7d	3	boleto	6	461.15	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27a-722d-8672-575f40bd1736	01a1c06e-d268-7163-b041-b8ee09a3e039	3	debit_card	9	864.28	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27a-722d-8672-575f413cb47b	01a1c06e-d269-7299-91ad-eb1d99877488	1	credit_card	1	483.80	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27a-722d-8672-575f416b93fe	01a1c06e-d26a-7291-9165-4c1f3ab0afa6	1	boleto	11	618.43	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27a-722d-8672-575f41b29ef6	01a1c06e-d26b-7014-89e8-8df66026f67f	3	boleto	12	290.82	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27b-709b-87d5-92d6f306d284	01a1c06e-d26c-73e6-aaf7-1b463f56583a	1	credit_card	7	130.86	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27b-709b-87d5-92d6f3249a1f	01a1c06e-d26d-71cf-a6d0-c40a82bb8094	3	boleto	1	254.83	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27b-709b-87d5-92d6f342549a	01a1c06e-d26e-7336-8698-3645541768d6	2	voucher	8	715.65	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27b-709b-87d5-92d6f401f9c0	01a1c06e-d26f-71e3-b9f4-6b91628cc774	2	voucher	12	523.17	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27b-709b-87d5-92d6f484f88d	01a1c06e-d270-71f4-90d1-40fdf27d6b3a	2	credit_card	1	737.13	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27c-7347-849d-53fc8c7f2972	01a1c06e-d271-7057-928e-7c08e7cea1d7	3	debit_card	6	512.91	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27c-7347-849d-53fc8d079900	01a1c06e-d272-704b-aa76-564cd042c146	3	boleto	8	993.00	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27c-7347-849d-53fc8db0f991	01a1c06e-d273-717c-a220-5834e26bed8b	1	boleto	4	526.81	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27c-7347-849d-53fc8e9eb494	01a1c06e-d274-7302-9565-dc88f05b5328	1	debit_card	10	299.55	2026-11-09 13:10:50	2026-11-09 13:10:50
\.


--
-- Data for Name: order_reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_reviews (id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, review_answer_timestamp, created_at, updated_at) FROM stdin;
01a1c06e-d292-737d-84ee-242ef0c91a05	01a1c06e-d27f-735a-a606-9e6a3157dcf2	3	\N	\N	2026-07-21 01:13:33	\N	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d294-732f-9b6a-39df8276c35c	01a1c06e-d280-71d5-a5e1-3f5136e46d1e	2	\N	\N	2026-09-24 16:17:22	2026-05-24 07:10:31	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d294-732f-9b6a-39df82fb1265	01a1c06e-d281-733b-ae56-987918f5420a	3	\N	Ut voluptate similique ad eius. Voluptate quibusdam enim voluptatum omnis quo veniam dolor voluptatem. Tenetur et est similique ut. Sed repellendus voluptatem iusto vel iste necessitatibus.	2026-05-11 09:50:14	\N	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d294-732f-9b6a-39df83bdcb7a	01a1c06e-d281-733b-ae56-9879197b7476	5	\N	\N	2026-09-19 18:02:07	2026-04-12 21:10:02	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d294-732f-9b6a-39df84487476	01a1c06e-d282-72ed-be12-f10e86cf6ad9	5	\N	\N	2026-08-23 05:53:50	2026-07-13 00:58:40	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d295-73ad-95d3-f362e481adbd	01a1c06e-d283-7104-81ef-96705eed6087	3	Necessitatibus minima maxime laboriosam.	Incidunt tenetur quo earum ex. Molestias quaerat repellat et. Tempora illo unde qui est iure dolore.	2026-11-09 13:08:24	2026-03-24 12:29:46	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d295-73ad-95d3-f362e5771ae9	01a1c06e-d284-736d-a4a0-ed46bfce2c8f	3	\N	Ratione iste inventore totam. Quia voluptate laboriosam enim expedita ipsa. Qui cumque rerum repellendus voluptatem omnis.	2026-10-07 03:29:28	\N	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d295-73ad-95d3-f362e6124395	01a1c06e-d285-73db-93ab-e12a4290cd98	5	Ratione nulla quo.	\N	2025-11-24 16:50:55	\N	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d296-736f-9e1a-1af194de5ee2	01a1c06e-d286-7128-bdcd-ad2d5f9cc307	1	Facere et.	\N	2026-07-18 04:22:36	2026-02-03 12:05:30	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d296-736f-9e1a-1af195d6b8a9	01a1c06e-d287-70a5-a006-b1ecc56d5d8d	2	\N	\N	2025-12-07 10:19:30	\N	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d296-736f-9e1a-1af196475184	01a1c06e-d288-73dc-a8a7-41d0087dfbbd	1	\N	\N	2025-12-08 15:03:35	\N	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d296-736f-9e1a-1af1967d5b7b	01a1c06e-d289-71fe-a62f-3d0fe49b94bb	5	Rerum cumque praesentium.	Quo consectetur recusandae facere ipsam quisquam cupiditate dolorem qui. Aperiam dolorem ea dolorem ducimus mollitia. Ut ea vero autem quo alias temporibus quia. Sit corrupti alias dolor eos voluptas et.	2026-05-12 04:28:00	\N	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d297-737b-a79e-5c057232bd33	01a1c06e-d28a-701d-a6f4-87651adf9b71	1	Iure ut non sint.	Expedita qui officiis adipisci nulla ut neque. Inventore rerum quis voluptas dolorem expedita. Rerum natus veritatis illum ea.	2026-04-20 08:20:21	\N	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d297-737b-a79e-5c0573117bb1	01a1c06e-d28b-72ef-9929-f08e7ae7c959	4	\N	Cumque et distinctio omnis incidunt et ex. Voluptatum eius in ut ut. Incidunt laudantium rerum est aut architecto iste. Rerum porro velit maiores qui omnis.	2026-11-07 22:06:15	\N	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d297-737b-a79e-5c057313f1c7	01a1c06e-d28c-70f4-afa1-768437daf2ce	5	\N	\N	2026-06-13 10:45:33	2026-02-15 19:27:23	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d297-737b-a79e-5c0573509bac	01a1c06e-d28d-736a-9450-4e2976cc6d55	4	Earum repellendus voluptates pariatur.	\N	2026-01-03 18:59:11	2026-02-23 20:40:19	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d298-720d-9727-03ba35bd1043	01a1c06e-d28e-7223-9aaa-5b61ddf70d2b	3	Rerum exercitationem porro accusamus.	\N	2026-04-03 14:18:29	2025-11-15 18:17:20	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d298-720d-9727-03ba361f153c	01a1c06e-d28f-7355-90ad-6121ffd452f2	1	Non corrupti ut.	\N	2026-07-01 16:59:02	2026-02-20 06:25:19	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d298-720d-9727-03ba366b83fb	01a1c06e-d291-732c-938a-52de7e242e4d	3	Ea nesciunt sit nostrum.	\N	2026-01-08 13:54:25	2025-12-02 02:49:52	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d298-720d-9727-03ba36a88f29	01a1c06e-d292-737d-84ee-242ef0b67fea	5	Et quis culpa aut.	Recusandae provident praesentium consequatur distinctio illum. Error deserunt quam delectus est qui inventore qui. Quis velit quia minima inventore.	2025-11-25 12:40:21	\N	2026-11-09 13:10:50	2026-11-09 13:10:50
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date, created_at, updated_at) FROM stdin;
01a1c06e-d1c4-7129-850c-13307cef218d	01a1c06e-d1aa-7297-a7af-05fceed4de58	canceled	2026-08-25 02:18:11	2026-04-08 13:38:07	2026-07-08 14:25:46	\N	2026-11-26 09:20:50	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c4-7129-850c-13307d93eb15	01a1c06e-d1ab-7087-ac4e-628f531e454a	delivered	2026-09-21 02:38:56	2026-03-07 20:56:22	\N	2026-06-14 01:31:37	2026-12-02 06:21:18	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c5-7225-b433-91eecc5b6cb5	01a1c06e-d1ac-7089-8272-1acad3d96d1d	approved	2026-06-25 23:51:20	2026-02-17 22:17:31	\N	\N	2026-11-24 06:18:44	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c5-7225-b433-91eeccbf9826	01a1c06e-d1ad-726a-8ca7-1850190a67ce	pending	2026-03-28 23:31:51	2026-05-17 18:37:40	2025-12-05 17:15:58	2026-11-01 05:09:00	2026-12-07 01:13:00	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c5-7225-b433-91eecd9c58f6	01a1c06e-d1ae-7165-98cb-7d3b4858b27c	shipped	2026-06-19 09:32:55	\N	2026-05-09 01:07:17	2026-04-02 10:51:33	2026-11-29 06:49:00	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c5-7225-b433-91eecdda774e	01a1c06e-d1af-733c-bcfc-b359ce800f3e	approved	2026-03-10 23:17:00	2026-04-06 13:19:01	2026-10-02 05:58:25	\N	2026-12-06 01:48:42	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c6-73ce-bc87-a80f865e64a3	01a1c06e-d1b0-73ba-b650-fcbbe0f61da1	shipped	2025-12-31 09:02:30	\N	\N	\N	2026-11-26 08:08:23	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c6-73ce-bc87-a80f86b1c07b	01a1c06e-d1b0-73ba-b650-fcbbe148a793	canceled	2026-05-13 14:54:20	2026-02-15 05:00:55	2026-10-16 02:08:07	2026-04-18 18:27:47	2026-11-27 05:25:15	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c7-714b-add4-0ab8d168945d	01a1c06e-d1b1-73d9-9864-7b16a82e3d90	pending	2026-08-04 17:17:12	2026-04-26 11:56:40	2026-06-05 13:10:13	\N	2026-11-19 21:45:51	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c7-714b-add4-0ab8d18b0318	01a1c06e-d1b2-705b-a8b5-5abcf7e3a6c2	shipped	2026-07-06 23:17:57	\N	2026-09-02 02:12:59	2026-02-06 12:44:32	2026-11-13 21:04:37	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c7-714b-add4-0ab8d202fbfa	01a1c06e-d1b3-71a8-8227-80d1f3a5737c	shipped	2026-03-11 18:03:09	2026-06-23 21:32:22	2025-11-19 06:45:11	\N	2026-11-14 04:45:20	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c7-714b-add4-0ab8d294984d	01a1c06e-d1b3-71a8-8227-80d1f47abf41	pending	2026-02-08 16:52:39	\N	2026-08-18 22:52:31	\N	2026-11-18 17:16:31	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c8-7337-a3fc-83db7c86900d	01a1c06e-d1b4-71e5-94b1-91ced6beea52	shipped	2026-08-16 08:25:23	\N	\N	2026-02-20 09:08:25	2026-11-16 18:37:41	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c8-7337-a3fc-83db7cb74b2d	01a1c06e-d1b5-70bc-b240-f0fc55663bb0	approved	2026-03-07 18:19:41	\N	\N	\N	2026-11-22 11:53:04	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c8-7337-a3fc-83db7cfc900b	01a1c06e-d1b6-711c-a7c4-3d3c318203bf	pending	2026-01-06 19:07:54	\N	2026-07-27 20:39:06	\N	2026-11-18 15:37:44	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c8-7337-a3fc-83db7da11853	01a1c06e-d1b7-72fb-9ba0-f14d2308e953	shipped	2025-12-28 19:56:53	2026-11-03 09:29:06	2026-09-19 10:16:39	\N	2026-12-05 07:00:11	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c8-7337-a3fc-83db7e98ebac	01a1c06e-d1b8-7384-9316-ba20c38259e1	pending	2026-04-29 06:09:56	2026-01-11 17:41:17	\N	2026-09-14 05:37:56	2026-11-12 22:07:26	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c9-70db-9885-393e5265e8ba	01a1c06e-d1b9-71b7-b25e-24ac65abb059	delivered	2026-07-22 11:04:06	2026-09-06 10:47:51	\N	\N	2026-11-12 17:27:50	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c9-70db-9885-393e52a4e5e4	01a1c06e-d1ba-7357-91bd-057d1461602f	delivered	2026-02-26 06:47:05	\N	\N	\N	2026-12-08 09:49:15	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1c9-70db-9885-393e53777035	01a1c06e-d1bb-7275-b45d-79bc9111fb3e	canceled	2026-06-16 11:36:02	2026-04-21 17:24:47	2026-04-12 22:30:57	\N	2026-12-03 18:33:48	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ca-71b3-b7be-38875724a7c4	01a1c06e-d1bc-71a8-afcb-7f8c2caee0b3	pending	2026-01-13 15:31:14	2026-08-22 02:50:03	\N	2026-09-15 13:08:25	2026-12-03 21:56:51	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ca-71b3-b7be-3887576122ce	01a1c06e-d1bd-7143-88d2-c7c6a1322016	canceled	2025-12-27 13:56:42	2026-01-04 08:47:51	2026-04-24 10:44:12	2026-08-18 03:31:32	2026-11-12 04:53:35	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ca-71b3-b7be-3887582d4ac6	01a1c06e-d1be-7019-84d1-c823d4f27e0c	canceled	2026-10-27 06:05:11	\N	\N	\N	2026-11-23 17:58:01	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ca-71b3-b7be-388759276a38	01a1c06e-d1bf-708d-b7ec-b7186cb0ca55	canceled	2026-02-17 04:47:44	\N	\N	\N	2026-11-19 17:06:13	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1cb-71d2-85e9-a9d31c2d7283	01a1c06e-d1c0-73df-b7bf-de620853bb17	shipped	2026-10-05 18:50:43	\N	\N	2026-05-18 22:09:37	2026-12-01 12:45:14	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1cb-71d2-85e9-a9d31cc80100	01a1c06e-d1c0-73df-b7bf-de6209106792	delivered	2026-04-02 18:56:29	2026-02-23 06:27:26	2026-10-25 14:36:06	\N	2026-11-30 12:18:20	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1cb-71d2-85e9-a9d31da9df08	01a1c06e-d1c1-73e5-9964-926f8fd3668f	canceled	2026-02-12 14:57:53	2026-05-10 15:58:56	2026-07-15 15:25:29	2026-10-10 17:35:36	2026-12-07 09:52:09	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1cc-71f2-84af-4addcc7db478	01a1c06e-d1c2-724d-82bd-e9eb359699bb	delivered	2026-06-19 10:38:13	2026-07-26 11:12:40	2025-12-27 06:58:08	\N	2026-12-07 06:50:32	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1cc-71f2-84af-4addcd62340e	01a1c06e-d1c3-7301-90a1-a2c7bc3db635	delivered	2025-11-10 23:47:29	\N	\N	\N	2026-11-11 08:20:54	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1cc-71f2-84af-4addcde73f8d	01a1c06e-d1c3-7301-90a1-a2c7bca49833	canceled	2026-10-09 10:05:07	\N	2025-11-29 12:25:09	2025-11-25 13:32:57	2026-11-11 03:35:30	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d0-73a3-8684-3aa4628c88c9	01a1c06e-d1d0-73a3-8684-3aa461fe8bce	delivered	2026-11-07 13:46:19	\N	2026-08-09 22:45:10	\N	2026-11-19 19:01:23	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d2-72b1-ae1f-fc5ad7f44884	01a1c06e-d1d2-72b1-ae1f-fc5ad73444f6	canceled	2026-08-28 20:41:21	2025-11-17 07:24:53	2026-01-02 17:08:54	2026-03-06 07:01:44	2026-11-22 15:16:32	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d3-7291-aa42-40faf25b12b2	01a1c06e-d1d3-7291-aa42-40faf224bf02	pending	2026-10-09 11:39:27	2026-04-22 04:45:00	2026-08-22 14:25:39	\N	2026-11-09 22:01:15	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d6-70f2-90db-9bc8e8e5071c	01a1c06e-d1d5-7193-bebb-7db26372dc99	approved	2026-03-11 11:59:59	\N	\N	2025-12-25 03:42:02	2026-11-10 12:50:08	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d8-718b-bbf0-edd6b3f5f9cf	01a1c06e-d1d7-70a0-985d-b4068f73a3b8	shipped	2026-07-04 07:14:22	2026-10-26 20:13:09	\N	2026-10-16 20:11:47	2026-11-13 14:17:48	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1da-71b4-bafd-45e629b0b779	01a1c06e-d1d9-7235-9098-41d0aff35b41	shipped	2026-03-17 21:34:48	2026-02-01 15:21:01	\N	2026-05-06 15:51:22	2026-12-02 18:37:01	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1db-7103-835f-f5bbf73bb495	01a1c06e-d1db-7103-835f-f5bbf6d8b347	pending	2026-08-13 02:01:56	\N	\N	2026-01-17 06:53:00	2026-11-17 01:50:36	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1dd-7189-8086-082032c975d8	01a1c06e-d1dd-7189-8086-082032b9229f	delivered	2026-05-18 13:01:26	2025-11-19 13:39:14	\N	2026-03-03 03:16:10	2026-11-25 13:57:56	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1df-73ab-955b-ee08d13a370d	01a1c06e-d1df-73ab-955b-ee08d0a85c91	delivered	2026-07-07 18:17:34	2026-08-02 11:45:06	\N	\N	2026-11-10 08:58:50	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e1-7305-801b-8383052e381f	01a1c06e-d1e0-72c2-9a03-1211676638a5	approved	2026-09-29 20:43:56	2026-07-20 09:52:40	2026-09-24 07:57:11	2026-02-05 09:05:09	2026-11-28 12:23:08	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e3-719a-9d7d-b389b030aaae	01a1c06e-d1e2-7340-bd40-5851edaa5dfb	delivered	2026-07-30 03:29:33	\N	2026-07-05 03:38:39	2026-08-23 06:17:18	2026-12-07 20:24:31	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e4-7106-a0f0-4fc070c08404	01a1c06e-d1e4-7106-a0f0-4fc070178668	delivered	2026-10-28 22:12:40	\N	2026-05-27 20:57:36	2026-03-23 06:51:08	2026-11-24 04:44:29	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e6-7186-8c3b-340088f8f03c	01a1c06e-d1e6-7186-8c3b-3400886f49b9	delivered	2026-03-25 22:30:14	2026-04-21 10:54:24	2026-06-30 04:59:35	2026-08-22 11:04:21	2026-11-18 05:41:29	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e8-734c-bdb3-3e7c33a36a13	01a1c06e-d1e8-734c-bdb3-3e7c32c8dd5a	pending	2026-10-24 13:35:52	2026-04-15 17:41:36	\N	2026-04-24 22:55:23	2026-11-25 00:58:54	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ea-7213-9f9d-a025011c9a06	01a1c06e-d1ea-7213-9f9d-a02500f394bb	approved	2026-05-23 17:23:20	2026-02-02 12:44:52	\N	2026-02-10 01:08:42	2026-11-13 02:34:46	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ec-7342-a810-de4f5c80e983	01a1c06e-d1ec-7342-a810-de4f5c32b595	shipped	2026-08-09 21:41:33	\N	2025-11-18 16:45:19	\N	2026-11-18 21:17:39	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ee-708b-9944-50b5b0b6bdd0	01a1c06e-d1ee-708b-9944-50b5affd2af7	approved	2026-05-13 06:48:31	\N	\N	2026-04-20 16:54:37	2026-12-08 23:28:50	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f0-724d-a56f-2f278dd25c05	01a1c06e-d1f0-724d-a56f-2f278d7585d8	approved	2026-08-07 16:52:19	\N	\N	2026-06-10 06:12:18	2026-11-27 12:39:42	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f2-702c-8a7b-0cf5839456ba	01a1c06e-d1f2-702c-8a7b-0cf582d08ee3	delivered	2026-03-27 14:22:29	\N	2026-07-07 18:40:36	\N	2026-12-06 14:00:05	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f4-7152-83f3-e7b8b3a77524	01a1c06e-d1f4-7152-83f3-e7b8b343182f	shipped	2026-01-08 09:27:56	2025-11-15 00:08:35	\N	\N	2026-12-02 17:48:22	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f7-7278-966d-f941d1ae1acf	01a1c06e-d1f7-7278-966d-f941d0cec5fd	approved	2026-02-16 05:31:48	\N	2026-07-09 22:24:18	\N	2026-11-24 06:37:22	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f9-7226-b17d-cd2b995970ad	01a1c06e-d1f9-7226-b17d-cd2b98a1e35a	delivered	2025-12-02 12:18:10	2026-09-22 11:22:34	\N	2026-08-29 17:55:58	2026-11-15 16:41:51	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1fb-71b5-802e-da413863a404	01a1c06e-d1fb-71b5-802e-da4137a229df	shipped	2026-09-06 19:12:45	2026-05-16 08:13:01	2026-08-31 23:01:27	2026-02-03 04:23:41	2026-11-23 13:41:18	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1fe-7111-9b0c-8d815bfbb81e	01a1c06e-d1fe-7111-9b0c-8d815b29bee6	shipped	2026-08-05 23:05:49	2026-01-29 21:28:56	2026-02-07 12:27:59	\N	2026-12-02 08:07:06	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d201-705d-98c8-85188cc28c8c	01a1c06e-d200-7104-950f-ce2dce92be26	approved	2026-01-31 09:43:29	2026-03-27 05:42:12	\N	\N	2026-11-20 13:15:43	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d203-72c0-bb85-cd28fd7aae7a	01a1c06e-d203-72c0-bb85-cd28fcf7bc2d	shipped	2026-03-27 05:50:06	\N	\N	2026-11-05 08:16:02	2026-11-11 06:23:20	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d206-7165-a460-84a7006b3ba0	01a1c06e-d205-7374-9cd4-526728f87e7b	pending	2026-10-06 05:26:30	\N	\N	2026-02-01 00:19:53	2026-11-15 16:30:33	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d208-70fb-95b4-bd27f7ecbcb4	01a1c06e-d207-7360-8002-63b797a12ea5	canceled	2026-09-13 10:35:20	\N	2026-08-13 07:58:04	\N	2026-11-13 08:31:01	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20a-7075-ad6b-099400b51c63	01a1c06e-d209-7397-b9c4-75f496157338	canceled	2026-08-29 05:05:22	\N	2026-04-26 09:26:16	2026-02-11 21:16:48	2026-11-10 17:08:36	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20c-70f0-8127-476eebfb53ef	01a1c06e-d20b-70d6-a1da-20124ee398bc	canceled	2026-09-17 16:39:11	2026-02-01 05:26:41	\N	2026-10-06 22:41:25	2026-12-07 07:03:22	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20e-7036-85e5-b7e187e9ba9c	01a1c06e-d20d-7151-9cdc-6109c857d1ae	pending	2025-12-11 09:01:55	2026-08-20 02:20:19	2026-06-19 20:55:55	\N	2026-12-02 16:25:20	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d210-704b-990a-004d16a5f065	01a1c06e-d20f-7086-9348-86b5f6bb0ca1	shipped	2026-10-24 18:12:56	\N	\N	2026-04-12 02:33:01	2026-11-16 03:34:25	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d211-72bb-b76d-73c8dd12b333	01a1c06e-d211-72bb-b76d-73c8dced5eb8	pending	2026-07-11 17:23:50	\N	\N	\N	2026-12-03 20:36:58	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d213-7347-a450-d8c7d9b48901	01a1c06e-d213-7347-a450-d8c7d978dac5	canceled	2026-08-28 20:15:42	2026-05-27 08:37:04	2026-09-25 09:29:28	\N	2026-11-23 19:52:40	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d215-7398-a89d-9729ebd042c9	01a1c06e-d215-7398-a89d-9729ebacd63c	canceled	2026-09-02 00:03:06	\N	\N	\N	2026-11-24 06:05:48	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d217-70e2-b377-81660911ed4f	01a1c06e-d217-70e2-b377-816608fbbbc9	canceled	2026-08-22 00:09:44	\N	\N	\N	2026-11-29 20:39:48	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d219-7071-a7d9-612cb9685e23	01a1c06e-d219-7071-a7d9-612cb8924878	approved	2026-08-04 09:49:25	\N	\N	\N	2026-11-20 03:15:48	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21b-70ba-8d50-71520c99c0ac	01a1c06e-d21a-7242-bd07-78273d3a281d	pending	2026-02-04 22:08:42	2026-07-03 22:02:37	\N	\N	2026-11-24 00:04:33	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21c-738c-83ca-750856719c95	01a1c06e-d21c-738c-83ca-750855a5d7aa	approved	2026-03-18 13:55:49	\N	2026-01-01 23:41:40	\N	2026-11-19 12:18:51	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21e-7310-8460-afed5e5fed3b	01a1c06e-d21e-7310-8460-afed5dd7899d	pending	2026-06-06 05:04:28	\N	2026-07-09 10:29:53	\N	2026-11-26 06:06:42	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d220-71a7-adbb-8b014beb9a2d	01a1c06e-d220-71a7-adbb-8b014b98cc2f	shipped	2026-10-08 23:46:10	\N	2026-03-26 02:29:22	2026-10-15 15:00:50	2026-11-15 22:36:00	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d222-724e-897e-2a3e94d5c49b	01a1c06e-d222-724e-897e-2a3e943425c7	approved	2025-12-29 20:02:38	2026-01-22 15:41:32	\N	\N	2026-11-15 18:19:53	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d224-736d-a04f-91fd0ab8b65f	01a1c06e-d224-736d-a04f-91fd0a1a64ff	delivered	2026-09-13 07:44:20	2026-04-07 03:39:33	\N	2026-04-12 00:27:02	2026-11-27 03:06:33	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d226-711d-986b-fd70f3a2a543	01a1c06e-d225-7213-8d2b-e57a5ae96f55	shipped	2026-10-10 16:58:12	\N	\N	\N	2026-12-08 13:46:57	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d228-72a4-abfe-4d3229118d0c	01a1c06e-d227-7186-a268-e4abbb8d6108	pending	2026-09-26 19:33:38	2026-07-19 00:02:07	\N	2026-01-21 09:52:46	2026-12-07 00:26:05	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22a-71cf-bb1a-71ce63700a19	01a1c06e-d22a-71cf-bb1a-71ce628c0656	canceled	2026-04-22 14:04:58	2025-12-10 17:15:15	\N	2026-03-26 05:20:02	2026-11-10 19:58:17	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22c-72d2-a1a3-dfa5805c6695	01a1c06e-d22c-72d2-a1a3-dfa57fa5e0b7	shipped	2026-09-03 11:01:20	\N	2025-11-19 00:27:49	2025-11-26 04:03:15	2026-11-21 18:29:49	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22e-7294-8815-c29cb4f03296	01a1c06e-d22d-71cd-8f54-0c5b24640dce	approved	2026-06-02 04:06:11	2026-11-01 09:26:29	\N	\N	2026-11-21 12:28:49	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22f-70a0-abba-dd0c27e426d8	01a1c06e-d22f-70a0-abba-dd0c2747df16	delivered	2026-03-14 03:12:06	\N	2025-11-27 03:46:15	\N	2026-12-01 16:48:39	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d231-7110-a20c-e757fcf5e264	01a1c06e-d231-7110-a20c-e757fc2f5c8e	approved	2026-06-11 10:34:39	\N	2025-12-03 07:51:59	2026-04-02 12:15:48	2026-11-10 12:08:57	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d232-71f4-aa90-d8a26d9d8502	01a1c06e-d232-71f4-aa90-d8a26d5ab2a2	approved	2026-09-21 14:56:21	\N	\N	\N	2026-11-21 11:33:04	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d234-70b6-bd11-a9b3ca1edaab	01a1c06e-d234-70b6-bd11-a9b3c98ca380	pending	2026-01-28 10:54:58	2026-09-02 10:30:50	\N	2026-09-03 19:18:10	2026-11-29 19:19:01	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d236-72ca-8e67-e3a24d5ae4b4	01a1c06e-d235-7118-96a5-184e7a0c92ce	approved	2026-01-16 01:52:18	\N	2026-01-30 17:17:55	2026-05-16 06:42:23	2026-11-30 18:48:53	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d238-734b-8a73-521ac5c748b2	01a1c06e-d237-71d5-b02e-59c9c6a7db59	canceled	2026-10-08 19:01:50	2025-12-08 17:16:52	2025-11-20 15:47:16	2026-02-04 10:11:15	2026-12-02 04:05:37	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23a-729e-8a88-f8b8bfb71483	01a1c06e-d239-7130-901b-784b95a0f520	shipped	2026-08-25 08:59:50	2025-11-27 14:12:00	\N	2026-09-29 13:59:47	2026-11-17 06:57:12	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23c-73b2-a16f-c97a5e018dbd	01a1c06e-d23b-7179-9e1f-90ed5ad2d522	delivered	2026-06-20 19:13:26	2026-01-05 05:14:31	\N	\N	2026-11-19 15:48:39	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23e-724e-92b2-6c6e683ea955	01a1c06e-d23d-7003-8abf-8efcf27a6d60	canceled	2026-05-12 23:40:19	\N	2026-05-24 16:05:19	\N	2026-11-11 14:54:27	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d240-7011-ac53-c771df8fa0e6	01a1c06e-d23f-7078-a71c-a56972525afb	pending	2026-05-08 08:11:36	\N	2026-07-06 06:41:43	\N	2026-11-14 23:54:02	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d242-71f9-930f-3fb88ae61a30	01a1c06e-d241-729c-9d79-a11fa634deff	approved	2026-04-28 18:44:49	2026-08-17 02:31:18	\N	\N	2026-11-09 19:00:44	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d244-726e-b9a5-11fce0335d52	01a1c06e-d243-7320-b5e4-7e2580e3536f	canceled	2026-07-13 09:08:08	\N	\N	2026-07-31 19:18:45	2026-11-29 06:25:24	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d258-71e1-b5e5-94c244d66e73	01a1c06e-d258-71e1-b5e5-94c243d7f10c	delivered	2026-10-16 07:14:01	2026-10-09 14:20:04	2026-09-15 17:59:35	2026-05-24 16:27:05	2026-11-22 15:58:30	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25a-70a0-926d-60e90757caa0	01a1c06e-d259-71fa-a26f-46a9fc1e134f	delivered	2026-11-07 12:51:35	\N	\N	2026-07-18 02:09:55	2026-11-20 09:49:59	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25b-7207-93ba-def6422a13af	01a1c06e-d25a-70a0-926d-60e908514eee	shipped	2026-08-27 02:30:06	\N	\N	2026-05-04 00:30:52	2026-11-21 07:58:27	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25b-7207-93ba-def6436e139e	01a1c06e-d25b-7207-93ba-def6431c9f5f	shipped	2026-10-25 07:58:38	\N	2026-07-01 11:26:19	2026-02-10 21:35:26	2026-12-02 13:25:34	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25c-728f-a3b4-46cc8f7c83e6	01a1c06e-d25c-728f-a3b4-46cc8e9ce361	pending	2026-03-07 22:31:06	2026-01-30 02:17:34	\N	2025-12-28 07:27:54	2026-11-16 20:19:09	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25d-718f-b092-d80bd1a29f49	01a1c06e-d25d-718f-b092-d80bd1107009	delivered	2026-07-02 11:58:21	2026-06-13 09:13:19	\N	2025-12-25 16:01:58	2026-11-29 16:20:45	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25e-71b2-88e6-7d1d0e402789	01a1c06e-d25e-71b2-88e6-7d1d0d4fee56	delivered	2025-11-20 04:54:12	2026-08-12 14:40:17	\N	2026-01-13 07:07:05	2026-12-08 09:47:40	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d25f-729b-a2ca-979492ef4754	01a1c06e-d25f-729b-a2ca-979492d91f0b	delivered	2026-03-14 15:55:00	\N	2026-03-20 17:08:50	2026-02-13 17:42:20	2026-11-12 10:13:31	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d260-7186-875a-15c307d44590	01a1c06e-d260-7186-875a-15c30787bb3c	approved	2026-06-19 08:49:09	\N	2026-01-27 07:00:35	2026-07-25 14:51:47	2026-11-27 16:18:20	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d261-717a-bbc0-3aab3a32f7a1	01a1c06e-d260-7186-875a-15c308514af7	pending	2026-01-06 01:38:35	\N	\N	2026-11-07 08:42:36	2026-12-01 19:55:02	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d262-737c-8cba-5dbc172d4bd5	01a1c06e-d261-717a-bbc0-3aab3a3363e8	canceled	2026-06-27 13:25:18	2026-05-02 01:00:31	\N	2026-10-15 19:15:54	2026-11-22 18:23:35	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d262-737c-8cba-5dbc17dcb220	01a1c06e-d262-737c-8cba-5dbc172e3b8f	pending	2026-05-11 10:00:52	2026-06-03 11:55:17	2026-10-26 22:31:51	\N	2026-11-25 09:22:05	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d263-736a-b8cc-de36ab17f935	01a1c06e-d263-736a-b8cc-de36ab1753e3	shipped	2026-01-19 11:09:35	2026-06-05 23:53:33	\N	\N	2026-11-12 15:37:25	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d264-738e-8ff8-88781289bca6	01a1c06e-d264-738e-8ff8-887812115150	delivered	2026-03-01 21:42:04	\N	\N	\N	2026-11-10 17:52:10	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d266-710d-8862-59da1008739f	01a1c06e-d265-725c-995d-f7cdd1851faa	pending	2025-11-12 01:03:51	2026-05-06 15:43:08	2025-11-29 22:51:44	\N	2026-12-05 04:48:22	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d267-728f-b6f2-45711214e1ff	01a1c06e-d266-710d-8862-59da107dcbf1	shipped	2026-10-11 21:10:37	2026-01-27 22:55:30	\N	\N	2026-11-20 00:49:48	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d268-7163-b041-b8ee080e2a7d	01a1c06e-d267-728f-b6f2-457112848c3f	delivered	2026-09-18 22:17:50	\N	\N	2026-01-25 15:16:16	2026-11-23 18:50:48	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d268-7163-b041-b8ee09a3e039	01a1c06e-d268-7163-b041-b8ee09094374	pending	2025-12-16 12:37:03	\N	2026-03-21 02:57:02	2026-04-15 06:06:38	2026-11-16 13:14:44	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d269-7299-91ad-eb1d99877488	01a1c06e-d269-7299-91ad-eb1d98fdae5f	pending	2026-08-10 02:15:46	2026-04-05 09:42:22	2026-03-27 08:13:13	\N	2026-11-17 03:39:08	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26a-7291-9165-4c1f3ab0afa6	01a1c06e-d26a-7291-9165-4c1f3a505960	canceled	2026-07-15 05:42:20	\N	\N	2026-02-28 19:05:39	2026-12-04 07:25:51	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26b-7014-89e8-8df66026f67f	01a1c06e-d26b-7014-89e8-8df65f47496d	pending	2026-08-26 04:22:17	\N	\N	\N	2026-11-28 03:53:47	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26c-73e6-aaf7-1b463f56583a	01a1c06e-d26c-73e6-aaf7-1b463eeba3c5	canceled	2026-04-07 07:13:53	\N	\N	\N	2026-11-29 13:44:43	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26d-71cf-a6d0-c40a82bb8094	01a1c06e-d26d-71cf-a6d0-c40a81c96ff5	pending	2026-04-09 07:38:41	\N	\N	2026-01-12 23:36:51	2026-11-10 08:06:59	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26e-7336-8698-3645541768d6	01a1c06e-d26e-7336-8698-364553b87c46	approved	2026-09-12 08:38:52	\N	\N	2026-11-08 18:56:30	2026-12-03 07:11:13	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d26f-71e3-b9f4-6b91628cc774	01a1c06e-d26f-71e3-b9f4-6b9162180208	approved	2026-05-15 12:22:26	\N	\N	2026-04-26 10:41:43	2026-12-09 02:31:31	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d270-71f4-90d1-40fdf27d6b3a	01a1c06e-d270-71f4-90d1-40fdf21a95b7	pending	2026-01-12 07:19:56	2026-09-17 04:24:58	\N	2026-03-19 02:59:52	2026-11-25 22:07:52	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d271-7057-928e-7c08e7cea1d7	01a1c06e-d270-71f4-90d1-40fdf36f5d5a	canceled	2026-06-08 05:09:52	2026-07-27 06:00:31	\N	2026-07-01 16:20:06	2026-12-02 03:32:57	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d272-704b-aa76-564cd042c146	01a1c06e-d271-7057-928e-7c08e8b54f68	delivered	2025-12-09 14:46:57	2026-10-04 07:51:12	2026-10-20 06:53:20	2026-10-30 16:42:08	2026-12-03 18:45:45	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d273-717c-a220-5834e26bed8b	01a1c06e-d272-704b-aa76-564cd06985d3	approved	2026-01-10 11:32:13	2025-12-26 15:43:58	2025-12-03 09:41:23	2025-12-25 06:20:11	2026-11-19 16:11:54	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d274-7302-9565-dc88f05b5328	01a1c06e-d273-717c-a220-5834e2794d4d	pending	2025-12-15 17:59:32	\N	2026-07-13 12:00:34	2026-01-11 03:19:29	2026-11-09 20:36:39	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d27f-735a-a606-9e6a3157dcf2	01a1c06e-d27e-70d1-8b05-53c34bc53e44	approved	2025-12-21 02:43:46	2025-11-20 04:05:26	\N	\N	2026-11-26 09:32:41	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d280-71d5-a5e1-3f5136e46d1e	01a1c06e-d27f-735a-a606-9e6a31d78636	canceled	2026-04-02 10:33:35	2026-05-28 00:13:17	\N	2026-04-06 20:10:21	2026-11-19 12:54:42	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d281-733b-ae56-987918f5420a	01a1c06e-d280-71d5-a5e1-3f5137b5bb41	pending	2026-11-06 10:08:51	\N	2026-10-17 22:57:09	2026-11-02 13:19:24	2026-11-13 19:29:57	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d281-733b-ae56-9879197b7476	01a1c06e-d281-733b-ae56-98791910213c	shipped	2026-02-07 10:31:48	2026-09-28 00:02:49	2026-08-15 07:24:16	\N	2026-11-19 06:12:34	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d282-72ed-be12-f10e86cf6ad9	01a1c06e-d282-72ed-be12-f10e862502b1	delivered	2026-10-09 13:13:36	2026-07-16 15:46:13	\N	\N	2026-11-29 05:36:42	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d283-7104-81ef-96705eed6087	01a1c06e-d283-7104-81ef-96705edf901e	shipped	2026-04-28 07:04:38	\N	2026-05-23 18:53:57	2026-09-29 01:19:53	2026-11-12 05:56:45	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d284-736d-a4a0-ed46bfce2c8f	01a1c06e-d284-736d-a4a0-ed46bf86329d	delivered	2026-01-23 17:37:47	2026-06-13 03:59:36	\N	\N	2026-11-16 17:59:46	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d285-73db-93ab-e12a4290cd98	01a1c06e-d284-736d-a4a0-ed46c00cf1d5	canceled	2026-10-30 03:46:07	2025-11-27 11:39:56	\N	\N	2026-11-29 18:02:15	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d286-7128-bdcd-ad2d5f9cc307	01a1c06e-d285-73db-93ab-e12a42ecb256	shipped	2026-03-05 18:03:18	2026-03-20 10:34:34	\N	\N	2026-11-13 17:38:14	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d287-70a5-a006-b1ecc56d5d8d	01a1c06e-d286-7128-bdcd-ad2d6015e28d	shipped	2026-07-28 13:14:56	\N	\N	\N	2026-11-14 19:23:07	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d288-73dc-a8a7-41d0087dfbbd	01a1c06e-d287-70a5-a006-b1ecc5c02324	shipped	2025-11-18 18:59:35	2026-11-01 12:55:51	2026-02-01 09:06:42	\N	2026-11-20 16:46:34	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d289-71fe-a62f-3d0fe49b94bb	01a1c06e-d288-73dc-a8a7-41d008b98c8b	canceled	2025-12-30 16:51:19	2026-07-08 19:33:29	\N	2026-10-19 21:11:51	2026-11-23 02:08:10	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28a-701d-a6f4-87651adf9b71	01a1c06e-d28a-701d-a6f4-87651a8cbc21	delivered	2026-09-20 17:34:56	2026-02-27 17:39:41	\N	2026-01-23 09:22:53	2026-11-18 07:05:54	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28b-72ef-9929-f08e7ae7c959	01a1c06e-d28b-72ef-9929-f08e79f55980	canceled	2026-06-15 08:59:23	\N	2026-05-29 04:34:48	\N	2026-11-29 02:23:44	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28c-70f4-afa1-768437daf2ce	01a1c06e-d28c-70f4-afa1-768436e89f5f	canceled	2026-03-04 05:36:39	2026-08-11 02:19:13	\N	2026-08-10 14:52:04	2026-11-26 10:05:24	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28d-736a-9450-4e2976cc6d55	01a1c06e-d28d-736a-9450-4e29767e08a8	approved	2025-12-16 14:07:43	2026-02-28 12:47:02	2026-08-05 21:17:08	\N	2026-11-26 00:56:51	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28e-7223-9aaa-5b61ddf70d2b	01a1c06e-d28e-7223-9aaa-5b61dd469b70	shipped	2026-03-28 00:21:20	2026-07-11 06:26:21	2026-01-24 19:17:58	\N	2026-12-04 19:12:50	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d28f-7355-90ad-6121ffd452f2	01a1c06e-d28f-7355-90ad-6121ffa0edd2	approved	2026-07-05 00:08:01	2026-07-06 19:49:59	2026-10-23 20:35:20	\N	2026-11-27 21:33:24	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d291-732c-938a-52de7e242e4d	01a1c06e-d290-72e5-a751-25e4ed74f28c	shipped	2026-05-04 04:13:49	\N	2026-05-15 19:03:33	2026-04-20 08:00:28	2026-11-25 07:40:07	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d292-737d-84ee-242ef0b67fea	01a1c06e-d291-732c-938a-52de7ea145b0	delivered	2026-03-01 16:55:01	2025-11-24 17:26:53	\N	\N	2026-11-25 16:12:22	2026-11-09 13:10:50	2026-11-09 13:10:50
\.


--
-- Data for Name: passkeys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passkeys (id, user_id, name, credential_id, credential, last_used_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: product_category_translations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_category_translations (product_category_name, product_category_name_english, created_at, updated_at) FROM stdin;
quas	Quas	2026-11-09 13:10:50	2026-11-09 13:10:50
dolor	Dolor	2026-11-09 13:10:50	2026-11-09 13:10:50
ut	Ut	2026-11-09 13:10:50	2026-11-09 13:10:50
dicta	Dicta	2026-11-09 13:10:50	2026-11-09 13:10:50
corporis	Corporis	2026-11-09 13:10:50	2026-11-09 13:10:50
voluptas	Voluptas	2026-11-09 13:10:50	2026-11-09 13:10:50
recusandae	Recusandae	2026-11-09 13:10:50	2026-11-09 13:10:50
omnis	Omnis	2026-11-09 13:10:50	2026-11-09 13:10:50
rem	Rem	2026-11-09 13:10:50	2026-11-09 13:10:50
quia	Quia	2026-11-09 13:10:50	2026-11-09 13:10:50
perspiciatis	Perspiciatis	2026-11-09 13:10:50	2026-11-09 13:10:50
neque	Neque	2026-11-09 13:10:50	2026-11-09 13:10:50
dolore	Dolore	2026-11-09 13:10:50	2026-11-09 13:10:50
perferendis	Perferendis	2026-11-09 13:10:50	2026-11-09 13:10:50
nesciunt	Nesciunt	2026-11-09 13:10:50	2026-11-09 13:10:50
non	Non	2026-11-09 13:10:50	2026-11-09 13:10:50
aut	Aut	2026-11-09 13:10:50	2026-11-09 13:10:50
eius	Eius	2026-11-09 13:10:50	2026-11-09 13:10:50
est	Est	2026-11-09 13:10:50	2026-11-09 13:10:50
odio	Odio	2026-11-09 13:10:50	2026-11-09 13:10:50
harum	Harum	2026-11-09 13:10:50	2026-11-09 13:10:50
ea	Ea	2026-11-09 13:10:50	2026-11-09 13:10:50
vel	Vel	2026-11-09 13:10:50	2026-11-09 13:10:50
doloremque	Doloremque	2026-11-09 13:10:50	2026-11-09 13:10:50
sunt	Sunt	2026-11-09 13:10:50	2026-11-09 13:10:50
exercitationem	Exercitationem	2026-11-09 13:10:50	2026-11-09 13:10:50
debitis	Debitis	2026-11-09 13:10:50	2026-11-09 13:10:50
eaque	Eaque	2026-11-09 13:10:50	2026-11-09 13:10:50
facere	Facere	2026-11-09 13:10:50	2026-11-09 13:10:50
quibusdam	Quibusdam	2026-11-09 13:10:50	2026-11-09 13:10:50
nihil	Nihil	2026-11-09 13:10:50	2026-11-09 13:10:50
distinctio	Distinctio	2026-11-09 13:10:50	2026-11-09 13:10:50
nulla	Nulla	2026-11-09 13:10:50	2026-11-09 13:10:50
sed	Sed	2026-11-09 13:10:50	2026-11-09 13:10:50
saepe	Saepe	2026-11-09 13:10:50	2026-11-09 13:10:50
facilis	Facilis	2026-11-09 13:10:50	2026-11-09 13:10:50
error	Error	2026-11-09 13:10:50	2026-11-09 13:10:50
molestiae	Molestiae	2026-11-09 13:10:50	2026-11-09 13:10:50
qui	Qui	2026-11-09 13:10:50	2026-11-09 13:10:50
accusantium	Accusantium	2026-11-09 13:10:50	2026-11-09 13:10:50
amet	Amet	2026-11-09 13:10:50	2026-11-09 13:10:50
nisi	Nisi	2026-11-09 13:10:50	2026-11-09 13:10:50
corrupti	Corrupti	2026-11-09 13:10:50	2026-11-09 13:10:50
fuga	Fuga	2026-11-09 13:10:50	2026-11-09 13:10:50
magni	Magni	2026-11-09 13:10:50	2026-11-09 13:10:50
ipsa	Ipsa	2026-11-09 13:10:50	2026-11-09 13:10:50
enim	Enim	2026-11-09 13:10:50	2026-11-09 13:10:50
assumenda	Assumenda	2026-11-09 13:10:50	2026-11-09 13:10:50
voluptatem	Voluptatem	2026-11-09 13:10:50	2026-11-09 13:10:50
id	Id	2026-11-09 13:10:50	2026-11-09 13:10:50
ipsam	Ipsam	2026-11-09 13:10:50	2026-11-09 13:10:50
rerum	Rerum	2026-11-09 13:10:50	2026-11-09 13:10:50
porro	Porro	2026-11-09 13:10:50	2026-11-09 13:10:50
ducimus	Ducimus	2026-11-09 13:10:50	2026-11-09 13:10:50
cumque	Cumque	2026-11-09 13:10:50	2026-11-09 13:10:50
et	Et	2026-11-09 13:10:50	2026-11-09 13:10:50
consequatur	Consequatur	2026-11-09 13:10:50	2026-11-09 13:10:50
quis	Quis	2026-11-09 13:10:50	2026-11-09 13:10:50
esse	Esse	2026-11-09 13:10:50	2026-11-09 13:10:50
iure	Iure	2026-11-09 13:10:50	2026-11-09 13:10:50
architecto	Architecto	2026-11-09 13:10:50	2026-11-09 13:10:50
quasi	Quasi	2026-11-09 13:10:50	2026-11-09 13:10:50
provident	Provident	2026-11-09 13:10:50	2026-11-09 13:10:50
deserunt	Deserunt	2026-11-09 13:10:50	2026-11-09 13:10:50
voluptatum	Voluptatum	2026-11-09 13:10:50	2026-11-09 13:10:50
necessitatibus	Necessitatibus	2026-11-09 13:10:50	2026-11-09 13:10:50
quae	Quae	2026-11-09 13:10:50	2026-11-09 13:10:50
at	At	2026-11-09 13:10:50	2026-11-09 13:10:50
aperiam	Aperiam	2026-11-09 13:10:50	2026-11-09 13:10:50
beatae	Beatae	2026-11-09 13:10:50	2026-11-09 13:10:50
sit	Sit	2026-11-09 13:10:50	2026-11-09 13:10:50
velit	Velit	2026-11-09 13:10:50	2026-11-09 13:10:50
dignissimos	Dignissimos	2026-11-09 13:10:50	2026-11-09 13:10:50
pariatur	Pariatur	2026-11-09 13:10:50	2026-11-09 13:10:50
minima	Minima	2026-11-09 13:10:50	2026-11-09 13:10:50
magnam	Magnam	2026-11-09 13:10:50	2026-11-09 13:10:50
totam	Totam	2026-11-09 13:10:50	2026-11-09 13:10:50
voluptate	Voluptate	2026-11-09 13:10:50	2026-11-09 13:10:50
molestias	Molestias	2026-11-09 13:10:50	2026-11-09 13:10:50
tempore	Tempore	2026-11-09 13:10:50	2026-11-09 13:10:50
earum	Earum	2026-11-09 13:10:50	2026-11-09 13:10:50
expedita	Expedita	2026-11-09 13:10:50	2026-11-09 13:10:50
unde	Unde	2026-11-09 13:10:50	2026-11-09 13:10:50
eos	Eos	2026-11-09 13:10:50	2026-11-09 13:10:50
repellendus	Repellendus	2026-11-09 13:10:50	2026-11-09 13:10:50
placeat	Placeat	2026-11-09 13:10:50	2026-11-09 13:10:50
autem	Autem	2026-11-09 13:10:50	2026-11-09 13:10:50
ipsum	Ipsum	2026-11-09 13:10:50	2026-11-09 13:10:50
ratione	Ratione	2026-11-09 13:10:50	2026-11-09 13:10:50
dolorem	Dolorem	2026-11-09 13:10:50	2026-11-09 13:10:50
maxime	Maxime	2026-11-09 13:10:50	2026-11-09 13:10:50
inventore	Inventore	2026-11-09 13:10:50	2026-11-09 13:10:50
voluptatibus	Voluptatibus	2026-11-09 13:10:50	2026-11-09 13:10:50
tenetur	Tenetur	2026-11-09 13:10:50	2026-11-09 13:10:50
sequi	Sequi	2026-11-09 13:10:50	2026-11-09 13:10:50
atque	Atque	2026-11-09 13:10:50	2026-11-09 13:10:50
doloribus	Doloribus	2026-11-09 13:10:50	2026-11-09 13:10:50
commodi	Commodi	2026-11-09 13:10:50	2026-11-09 13:10:50
quo	Quo	2026-11-09 13:10:50	2026-11-09 13:10:50
cum	Cum	2026-11-09 13:10:50	2026-11-09 13:10:50
consectetur	Consectetur	2026-11-09 13:10:50	2026-11-09 13:10:50
voluptates	Voluptates	2026-11-09 13:10:50	2026-11-09 13:10:50
dolores	Dolores	2026-11-09 13:10:50	2026-11-09 13:10:50
sapiente	Sapiente	2026-11-09 13:10:50	2026-11-09 13:10:50
veniam	Veniam	2026-11-09 13:10:50	2026-11-09 13:10:50
temporibus	Temporibus	2026-11-09 13:10:50	2026-11-09 13:10:50
excepturi	Excepturi	2026-11-09 13:10:50	2026-11-09 13:10:50
mollitia	Mollitia	2026-11-09 13:10:50	2026-11-09 13:10:50
nobis	Nobis	2026-11-09 13:10:50	2026-11-09 13:10:50
quisquam	Quisquam	2026-11-09 13:10:50	2026-11-09 13:10:50
officia	Officia	2026-11-09 13:10:50	2026-11-09 13:10:50
quaerat	Quaerat	2026-11-09 13:10:50	2026-11-09 13:10:50
fugit	Fugit	2026-11-09 13:10:50	2026-11-09 13:10:50
sint	Sint	2026-11-09 13:10:50	2026-11-09 13:10:50
tempora	Tempora	2026-11-09 13:10:50	2026-11-09 13:10:50
eligendi	Eligendi	2026-11-09 13:10:50	2026-11-09 13:10:50
nemo	Nemo	2026-11-09 13:10:50	2026-11-09 13:10:50
aspernatur	Aspernatur	2026-11-09 13:10:50	2026-11-09 13:10:50
consequuntur	Consequuntur	2026-11-09 13:10:50	2026-11-09 13:10:50
iste	Iste	2026-11-09 13:10:50	2026-11-09 13:10:50
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, product_category_name, product_name_length, product_description_length, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm, created_at, updated_at) FROM stdin;
01a1c06e-d189-728c-81cd-578740fbcc5f	perspiciatis	22	136	2	118.87	45.93	28.76	98.40	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d18c-7279-acd6-385a94b3cdb8	neque	47	25	4	649.07	60.82	50.87	58.74	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d18d-73aa-b248-1e39ac53eccd	dolore	10	62	1	337.92	88.95	16.83	34.92	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d18e-7077-b38e-f24e21d71ac9	perferendis	47	145	3	3896.80	90.34	48.91	46.83	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d18f-7175-ab1f-c1b267374b40	nesciunt	29	116	5	3359.90	91.99	46.11	32.92	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d191-701e-a201-21f915ffa153	non	6	51	4	4911.07	97.99	91.37	42.08	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d192-7230-a5f4-1841fbd63031	aut	11	57	4	2632.51	99.41	88.88	95.28	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d193-72a5-96f4-003793ab148d	eius	23	46	4	1365.77	86.70	27.00	59.35	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d194-70df-8fe5-216bf01109df	est	29	167	4	3078.89	15.23	90.92	36.87	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d194-70df-8fe5-216bf0125744	odio	29	37	2	4107.24	82.00	48.21	46.40	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d195-70fa-9537-14921ca8af0b	harum	14	95	2	2221.03	14.52	11.73	20.54	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d195-70fa-9537-14921d118e30	ea	41	97	4	3618.81	63.88	33.47	70.80	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d196-71f2-b5fc-ae948ce0eb3a	vel	20	46	1	4152.44	8.92	76.61	67.44	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d196-71f2-b5fc-ae948d8ffb22	doloremque	23	194	5	2884.92	56.70	27.27	15.82	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d197-7144-992e-832afc878386	sunt	26	102	1	119.71	36.29	54.90	30.45	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d197-7144-992e-832afcf5b641	exercitationem	7	173	3	4740.14	64.38	76.94	55.82	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d198-701b-810e-941ba5373948	debitis	38	22	1	2710.58	77.51	19.10	72.57	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d198-701b-810e-941ba62c7a2a	eaque	16	151	5	4221.79	14.53	68.87	92.51	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d199-7192-8396-4bbaceaa97d9	facere	31	145	5	129.04	98.79	43.10	37.82	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d199-7192-8396-4bbacefbe8d9	quibusdam	25	44	3	3116.48	84.70	74.71	15.54	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19a-7011-8683-d0a2230e074d	nihil	34	96	5	593.11	55.52	31.88	86.31	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19a-7011-8683-d0a2230f1f49	distinctio	9	31	5	2632.86	93.72	40.97	52.89	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19b-707d-a8fd-ecec6de883e9	nulla	6	118	2	4489.31	5.68	30.64	32.66	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19b-707d-a8fd-ecec6e4906e3	sed	47	89	5	4258.58	18.94	95.71	15.35	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19c-7343-aba2-a4d32cd5b699	saepe	8	36	3	1051.24	72.63	78.88	29.93	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19c-7343-aba2-a4d32d2deb77	facilis	47	62	5	1832.30	83.67	86.27	92.34	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19d-738a-b3af-3254cf6a6605	error	26	97	2	4818.21	32.13	33.53	6.78	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19d-738a-b3af-3254d001b967	molestiae	39	153	2	1227.69	89.67	58.89	75.93	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19e-7066-b3e1-75e575da2f9f	qui	18	74	1	4104.24	68.26	63.86	35.72	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19e-7066-b3e1-75e5767bcb53	accusantium	38	176	5	2784.67	87.79	53.42	41.40	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19e-7066-b3e1-75e576bea00d	amet	31	141	4	4810.55	70.56	23.21	57.09	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19f-7025-a929-ef42a3330b42	nisi	22	161	1	3878.42	65.01	21.48	37.89	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d19f-7025-a929-ef42a405f7a4	corrupti	32	148	2	3467.05	81.64	25.37	56.72	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a0-70eb-a999-4993e2350aab	fuga	30	162	3	2744.61	71.86	89.06	64.24	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a0-70eb-a999-4993e3147ddc	magni	22	177	5	3905.70	51.61	14.28	35.19	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a1-71ac-856f-92176809962b	ipsa	24	128	4	1446.72	91.48	54.50	17.00	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a1-71ac-856f-921768446922	enim	26	151	3	4733.35	89.48	20.20	5.11	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a1-71ac-856f-921768571323	assumenda	31	173	3	4042.01	54.81	50.97	73.70	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a2-722a-b22e-9ec384670fab	voluptatem	41	193	4	3281.93	90.77	88.37	90.78	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a2-722a-b22e-9ec384ad1174	id	38	189	4	2970.44	14.01	18.77	77.30	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a3-735c-ab69-71a69f843590	ipsam	25	81	1	1272.98	29.26	54.04	76.88	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a3-735c-ab69-71a6a05faaf3	rerum	12	67	4	4496.86	52.70	14.12	67.04	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a4-7008-a130-563a336e06d8	porro	39	25	4	914.07	97.23	36.27	63.94	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a4-7008-a130-563a343a2ae8	ducimus	12	25	3	2583.67	58.06	70.41	33.26	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a5-71a6-abcd-bcb142890b8c	cumque	34	57	5	893.68	29.80	93.78	92.33	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a5-71a6-abcd-bcb1430782c0	et	14	140	3	2881.44	64.69	86.27	21.99	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a6-736a-8ac3-268de606e31a	consequatur	49	183	5	2147.66	11.76	76.01	20.36	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a6-736a-8ac3-268de6fca42a	quis	13	39	1	928.95	48.51	73.92	10.74	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a7-7343-8b8e-ce948045df0e	esse	29	99	4	3769.86	63.89	13.62	40.80	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1a7-7343-8b8e-ce9480be43fa	iure	45	75	5	2645.92	72.81	43.95	73.88	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d1-7168-a5fd-5ffd11f8cfd8	architecto	30	142	5	2998.54	53.33	69.37	43.98	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d2-72b1-ae1f-fc5ad8a38663	quasi	11	91	3	3689.58	56.54	72.16	52.72	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d4-72f0-8b34-7a5b7f939e4c	provident	24	189	5	3984.40	83.42	76.80	97.12	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d6-70f2-90db-9bc8e9c02d97	deserunt	20	128	4	4127.10	88.03	51.29	57.78	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d8-718b-bbf0-edd6b4461fc6	voluptatum	33	44	3	3598.51	44.01	41.31	10.44	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1da-71b4-bafd-45e629f3c9e1	necessitatibus	16	50	3	3180.97	77.14	79.58	63.41	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1dc-70e3-b8ce-9b87bbd972cd	quae	30	140	4	555.87	16.93	79.91	34.85	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1de-7348-9d9f-4ec550f75bdc	at	16	198	3	4003.92	24.24	79.23	34.10	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1df-73ab-955b-ee08d18a251c	aperiam	9	49	1	642.96	6.67	35.53	6.74	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e1-7305-801b-838305cd3101	beatae	27	92	3	3139.17	31.73	44.79	56.74	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e3-719a-9d7d-b389b0942b5b	sit	26	34	4	2594.30	54.93	74.56	86.10	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e5-73d7-b2df-42529fae067c	velit	49	46	2	394.13	19.84	81.95	16.10	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e7-7102-a12a-7cb9d9729fe2	dignissimos	50	94	1	1130.08	17.94	72.52	57.61	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e9-72cf-8a87-0f1fbf74b744	pariatur	37	111	3	4555.61	64.29	59.52	87.98	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1eb-7361-9e83-8cf4295539c9	minima	39	43	4	4228.85	29.10	15.30	17.21	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ed-7252-9e4c-5605b5892bfa	magnam	33	48	1	333.18	58.13	12.96	58.86	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ef-7342-9b12-d87b51295230	totam	12	40	4	1023.58	47.50	90.44	60.93	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f1-73d5-b04e-0be279dc84f3	voluptate	35	31	3	729.39	12.32	52.83	77.40	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f3-724f-af4c-4b2da2f7bd64	molestias	49	46	5	1588.90	87.19	21.45	68.41	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f5-71c6-800c-f1afab348244	tempore	45	10	5	3244.34	39.17	6.89	27.51	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f8-718d-99e3-f4890e126f1c	earum	25	171	1	4960.14	96.70	76.49	46.30	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1fa-7035-8551-e4c8af2d6515	expedita	23	120	1	1094.66	75.54	60.37	24.11	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1fc-71d5-a0db-8c69206f017a	unde	42	115	3	4458.10	68.39	48.13	14.94	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ff-719e-a955-4b9f19ba8a1d	eos	26	102	2	671.33	63.21	51.21	50.68	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d201-705d-98c8-85188d5cf8c7	repellendus	17	169	1	144.15	30.50	33.11	85.40	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d204-7384-99c3-a534437e1760	placeat	29	135	2	1447.58	38.93	46.25	24.66	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d206-7165-a460-84a7008d73db	autem	48	36	1	1726.51	9.54	48.47	78.59	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d208-70fb-95b4-bd27f8d00091	ipsum	35	71	4	1228.62	44.44	65.13	43.83	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20a-7075-ad6b-09940125a67b	ratione	13	155	1	1871.05	70.26	67.97	41.18	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20c-70f0-8127-476eec064153	dolorem	24	26	5	3956.19	83.87	67.02	34.09	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20e-7036-85e5-b7e1880b2b53	maxime	29	192	2	2558.18	93.81	47.25	6.78	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d210-704b-990a-004d17094e38	inventore	9	114	1	4982.99	61.77	76.13	64.16	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d212-71dc-b48e-87f7d0bc287f	voluptatibus	37	76	3	4113.43	26.29	84.88	93.02	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d214-717b-a71a-8505ceb74bb3	tenetur	43	143	5	2606.82	64.00	40.74	90.33	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d216-72ef-b718-13b8b62e884a	sequi	10	20	4	3081.62	72.60	51.94	19.14	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d218-70bb-b72d-3e01223f9ea7	atque	44	42	5	1828.20	66.97	69.51	33.32	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d219-7071-a7d9-612cb9a5c3a7	doloribus	16	71	3	1642.06	94.37	15.83	91.70	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21b-70ba-8d50-71520cc08e09	commodi	31	84	1	4049.94	58.27	63.69	97.34	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21d-7205-86d4-7ecce918d5e3	quo	29	121	1	2428.26	81.96	35.04	55.90	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21f-71d9-a5b5-f1cf2b5d9e14	cum	14	72	4	4683.77	73.01	51.59	78.38	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d221-7339-a020-78aef056285e	consectetur	29	153	4	1279.47	46.49	74.41	92.40	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d223-7370-8314-c5d117798ce8	voluptates	35	131	3	3934.97	40.26	97.84	91.38	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d225-7213-8d2b-e57a5a5f004b	dolores	26	95	5	3101.74	20.38	84.50	55.97	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d226-711d-986b-fd70f3ea5480	sapiente	36	110	1	3588.41	33.32	5.72	63.81	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d228-72a4-abfe-4d32294ece43	veniam	14	114	2	3571.36	37.87	69.53	97.35	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22b-7360-8f55-2c678725ccf1	temporibus	49	177	5	3276.38	9.37	6.13	11.39	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22c-72d2-a1a3-dfa5811f625a	excepturi	43	25	2	2673.72	88.36	95.23	78.20	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22e-7294-8815-c29cb5e88478	mollitia	14	103	2	4879.35	83.51	31.27	6.54	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d230-73d1-9537-0c5a4b3b05a8	nobis	31	126	1	1920.63	60.95	44.84	47.06	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d231-7110-a20c-e757fd6ae0e2	quisquam	5	158	1	471.20	76.13	59.74	60.60	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d233-70d9-a4d7-24b9ab6d4e6a	officia	50	99	4	320.71	99.69	37.66	87.36	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d234-70b6-bd11-a9b3cab59f20	quaerat	8	179	2	4160.95	11.17	59.71	94.82	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d236-72ca-8e67-e3a24daba557	fugit	46	95	1	511.04	5.49	38.44	45.76	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d238-734b-8a73-521ac6530829	sint	22	27	2	2397.32	53.37	41.09	55.38	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23a-729e-8a88-f8b8c07df4a2	tempora	48	35	2	307.46	60.01	17.06	77.81	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23c-73b2-a16f-c97a5edbb6e8	eligendi	34	118	3	1367.21	89.70	39.58	55.86	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23e-724e-92b2-6c6e685bd76a	nemo	46	74	1	2090.30	86.45	50.46	20.49	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d240-7011-ac53-c771e014b052	aspernatur	34	28	2	516.04	64.53	45.77	80.63	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d242-71f9-930f-3fb88ba7fac3	consequuntur	9	52	1	4183.37	54.48	20.32	8.60	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d244-726e-b9a5-11fce0adce3b	iste	15	140	1	2505.47	41.35	52.00	51.89	2026-11-09 13:10:50	2026-11-09 13:10:50
\.


--
-- Data for Name: sellers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sellers (id, seller_zip_code_prefix, seller_city, seller_state, created_at, updated_at) FROM stdin;
01a1c06e-d13a-731f-9b4c-d790898fea3c	28158	Genefurt	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d13d-723c-bf18-c83b3a113729	54242-0282	West Eli	MI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d13e-71c4-b9a7-d12cbfb1b5d1	34930	Port Rickeybury	CA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d13f-71e1-8b84-1b1e7df318d0	37626	Roderickbury	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d140-7232-9808-70a803f0e710	42440	East Maxwell	DC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d141-714b-8bec-02c6f0a1153e	59538	North Floyd	CT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d141-714b-8bec-02c6f0b090da	02010	Bodeville	NV	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d145-7265-bd3e-a57a5f71a902	68400-5999	Drewhaven	TN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d146-726c-ba06-96db835978b2	47756-6574	Port Khalil	AK	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d146-726c-ba06-96db83e4d31f	43055-9140	New Dino	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d148-7256-97ca-1c19adcf31c8	57838	East Nicholasside	TN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d149-72af-bb4c-2ee55094151e	69894	New Aliza	CT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d149-72af-bb4c-2ee5517ad0fa	38474-9887	New Logan	NM	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d14a-70ea-b908-2c6e40834c3d	15544	Cooperfurt	ND	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d14b-71c4-a737-827ac2a8b010	61130-1072	Baronhaven	NM	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d14b-71c4-a737-827ac31466a1	56925	West Ernie	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d14c-70e1-b5dc-19046ec8e847	21780-2843	Johnnyhaven	NE	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d14d-730c-a42b-f4dcad189801	93668	Abelardostad	MN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d14e-71f8-be59-b4fbb6f909be	41922	North Julius	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d14f-712d-ab94-b35956740d23	10185-3584	Sauertown	KY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d1-7168-a5fd-5ffd127b08b4	11315	New Pansy	ME	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d3-7291-aa42-40faf1951bcb	20191	Kertzmannfurt	TX	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d5-7193-bebb-7db2628c7d8e	41171-3620	North Vivien	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d7-70a0-985d-b4068f298dc8	64155	Port Annettestad	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1d9-7235-9098-41d0af2a40fc	98784	Mayestad	TN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1db-7103-835f-f5bbf62d31a6	43665	Dickensfort	NM	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1dc-70e3-b8ce-9b87bc7213b0	84735-7810	East Buford	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1de-7348-9d9f-4ec551000edf	56223-1215	Alfredview	MD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e0-72c2-9a03-121166cf5994	73732-0195	North Estherberg	VA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e2-7340-bd40-5851ed3ac41c	08370-1245	West Rhiannonfort	HI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e4-7106-a0f0-4fc06f935b43	90414-4762	Mitchellhaven	NV	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e5-73d7-b2df-4252a0a82b1e	16883	Lake Emmitt	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e7-7102-a12a-7cb9da45b800	35311-4050	Jastside	TX	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1e9-72cf-8a87-0f1fc022abf3	45105	Omerbury	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1eb-7361-9e83-8cf429d99a95	02526-3073	Port Trebury	MN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ed-7252-9e4c-5605b60fff96	15150-6132	North Stephany	MA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ef-7342-9b12-d87b5223bbb2	33399-5452	Lake Olafberg	KS	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f1-73d5-b04e-0be27a7a814e	25311-1519	Port Otisbury	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f3-724f-af4c-4b2da315fb98	25809	McGlynnville	IN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f6-71e3-a583-50514443e926	56747	Monahanstad	MN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1f8-718d-99e3-f4890ea7fe16	89170	Lake Clotildemouth	IA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1fa-7035-8551-e4c8affabccd	09324	Kristown	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1fd-731f-96a7-38ca49ad00b7	62170-8815	East Julietport	LA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d1ff-719e-a955-4b9f1a4145ab	82759	West Samaraland	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d202-712c-b1ff-fac0fab36d19	64254	South Alia	MO	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d204-7384-99c3-a534441de562	83662-3096	Blockberg	UT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d207-7360-8002-63b797580dbd	99890	Devantehaven	DC	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d209-7397-b9c4-75f495577b54	03086-7125	Lake Mariah	LA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20b-70d6-a1da-20124e626e09	80152	Port Reggieport	UT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20c-70f0-8127-476eecef1631	63408-9376	Gottliebburgh	IL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d20f-7086-9348-86b5f6091764	77944	Gusikowskishire	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d211-72bb-b76d-73c8dc0c0f09	52375	Wolffport	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d212-71dc-b48e-87f7d176853f	95774	New Annabel	AL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d214-717b-a71a-8505cfa8c51c	94216-0946	South Marcellaburgh	AZ	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d216-72ef-b718-13b8b6bb934b	06299-4574	Josephineberg	VT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d218-70bb-b72d-3e0122e9a765	69382	Lake Daphnetown	NJ	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21a-7242-bd07-78273cd700dc	84314	Lucyville	WV	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21b-70ba-8d50-71520cd188ee	18904	North Melliemouth	ND	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21d-7205-86d4-7ecce953ad1d	68197	Waltermouth	TX	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d21f-71d9-a5b5-f1cf2b7bdd38	42378	South Maxieville	SD	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d221-7339-a020-78aef0a39714	58254-9314	Kuhicborough	ND	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d223-7370-8314-c5d117e9565c	95713	Lake America	CT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d225-7213-8d2b-e57a5ac19fe4	19404-3119	New Melanybury	OR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d227-7186-a268-e4abbb7c41f6	77535	Lynchville	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d229-71c7-883d-9cf884c80a6b	29697-2149	Denesikborough	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22b-7360-8f55-2c6787f7383c	57921-8239	South Cameronbury	AR	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22d-71cd-8f54-0c5b24538e70	83665	Kayleyberg	ME	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d22e-7294-8815-c29cb5fc4a37	67394	Lake Kendrick	RI	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d230-73d1-9537-0c5a4b927fbb	85075	Sherwoodberg	MA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d231-7110-a20c-e757fdd8b97b	84449-1342	Millerstad	MT	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d233-70d9-a4d7-24b9abf9766b	62027-7426	Cummerataview	NY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d235-7118-96a5-184e79ad5dd4	73259-3333	North Estelbury	TN	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d236-72ca-8e67-e3a24e8d2314	51261	Loraineburgh	WY	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d239-7130-901b-784b956664a6	59272	Reichelport	VA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23b-7179-9e1f-90ed5a18935c	72672-5950	Watsicamouth	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23c-73b2-a16f-c97a5f30a141	54521-6943	West Nobleborough	IA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d23f-7078-a71c-a569719ca755	95027	Malindastad	GA	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d241-729c-9d79-a11fa5d865e2	36590-3902	Port Glen	CO	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d242-71f9-930f-3fb88c7c27a7	97981-7510	Port Vadatown	FL	2026-11-09 13:10:50	2026-11-09 13:10:50
01a1c06e-d244-726e-b9a5-11fce170f8f2	19224-7045	Port Brycenton	HI	2026-11-09 13:10:50	2026-11-09 13:10:50
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
gaPglosGrrJq7DxZ1QYxEWkAPpMtpfhfSfhDgpfc	\N	127.0.0.1	curl/8.7.1	eyJfdG9rZW4iOiJCa1c2V2ZaRURCdGVOZ1FBS2lsWTBDYW90U1pPTDRxaVhLSUo2cDY3IiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDgwXC9sb2dpbiIsInJvdXRlIjoibG9naW4ifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119fQ==	1794232709
h6E1XKY9WfJ7YmFV5yc5ECldEzO9OSYA6CAWjFrA	01a1c06e-d038-73b3-a4f6-f69588a86220	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36	eyJfdG9rZW4iOiJuSkh0S2UwSnlSREFCa1U1andiYUp5ak45anJoZW82WEg1VUxMR0RWIiwidXJsIjp7ImludGVuZGVkIjoiaHR0cHM6XC9cL25ldGNvbS50ZXN0XC9zZXR0aW5nc1wvc2VjdXJpdHkifSwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHBzOlwvXC9uZXRjb20udGVzdFwvZGFzaGJvYXJkIiwicm91dGUiOiJkYXNoYm9hcmQifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI6IjAxYTFjMDZlLWQwMzgtNzNiMy1hNGY2LWY2OTU4OGE4NjIyMCIsInBhc3N3b3JkX2hhc2hfd2ViIjoiMDQ2M2FkNTQzY2U5YjUyNTlhYTNjMTQzZmQ3M2M5MzIwMWJkNGEyN2M1YWYwZGJiZDY0MzE4ZWY3YjYxOTUxNiJ9	1794234328
HpEZG0K8NEcIhJf0x03ySH4QbKNyubZqwr6aQ856	\N	127.0.0.1	HerdApplications	eyJfdG9rZW4iOiJITjdtVTdLS1FqN1JSMzJHSDVleEkzeVBpY2Npc0JHUzNjNlNjUEtiIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHBzOlwvXC9uZXRjb20udGVzdFwvP2hlcmQ9cHJldmlldyIsInJvdXRlIjoiaG9tZSJ9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19	1794234332
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, two_factor_secret, two_factor_recovery_codes, two_factor_confirmed_at) FROM stdin;
01a1c06e-d038-73b3-a4f6-f69588a86220	Test Admin	admin@app.com	2026-11-09 13:10:49	$2y$12$RE2E6OGGtAo6ldMOnGlja.bnUnmD208LZhQRmfqhFdHsfXQCtsXLe	LaOeUGxGYf	2026-11-09 13:10:50	2026-11-09 13:10:50	\N	\N	\N
\.


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 15, true);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: geolocations geolocations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.geolocations
    ADD CONSTRAINT geolocations_pkey PRIMARY KEY (geolocation_zip_code_prefix);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: order_payments order_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_payments
    ADD CONSTRAINT order_payments_pkey PRIMARY KEY (id);


--
-- Name: order_reviews order_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_reviews
    ADD CONSTRAINT order_reviews_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: passkeys passkeys_credential_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passkeys
    ADD CONSTRAINT passkeys_credential_id_unique UNIQUE (credential_id);


--
-- Name: passkeys passkeys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passkeys
    ADD CONSTRAINT passkeys_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: product_category_translations product_category_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_category_translations
    ADD CONSTRAINT product_category_translations_pkey PRIMARY KEY (product_category_name);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: sellers sellers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sellers
    ADD CONSTRAINT sellers_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: customers_customer_city_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX customers_customer_city_index ON public.customers USING btree (customer_city);


--
-- Name: customers_customer_zip_code_prefix_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX customers_customer_zip_code_prefix_index ON public.customers USING btree (customer_zip_code_prefix);


--
-- Name: failed_jobs_connection_queue_failed_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX failed_jobs_connection_queue_failed_at_index ON public.failed_jobs USING btree (connection, queue, failed_at);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: order_items_order_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_items_order_id_index ON public.order_items USING btree (order_id);


--
-- Name: order_items_product_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_items_product_id_index ON public.order_items USING btree (product_id);


--
-- Name: order_items_seller_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_items_seller_id_index ON public.order_items USING btree (seller_id);


--
-- Name: order_payments_order_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_payments_order_id_index ON public.order_payments USING btree (order_id);


--
-- Name: order_payments_payment_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_payments_payment_type_index ON public.order_payments USING btree (payment_type);


--
-- Name: order_reviews_order_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_reviews_order_id_index ON public.order_reviews USING btree (order_id);


--
-- Name: orders_customer_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_customer_id_index ON public.orders USING btree (customer_id);


--
-- Name: orders_order_purchase_timestamp_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_order_purchase_timestamp_index ON public.orders USING btree (order_purchase_timestamp);


--
-- Name: orders_order_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_order_status_index ON public.orders USING btree (order_status);


--
-- Name: passkeys_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX passkeys_user_id_index ON public.passkeys USING btree (user_id);


--
-- Name: products_product_category_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_product_category_name_index ON public.products USING btree (product_category_name);


--
-- Name: sellers_seller_city_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sellers_seller_city_index ON public.sellers USING btree (seller_city);


--
-- Name: sellers_seller_state_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sellers_seller_state_index ON public.sellers USING btree (seller_state);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: customers customers_customer_zip_code_prefix_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_customer_zip_code_prefix_foreign FOREIGN KEY (customer_zip_code_prefix) REFERENCES public.geolocations(geolocation_zip_code_prefix) ON DELETE SET NULL;


--
-- Name: order_items order_items_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_seller_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_seller_id_foreign FOREIGN KEY (seller_id) REFERENCES public.sellers(id) ON DELETE CASCADE;


--
-- Name: order_payments order_payments_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_payments
    ADD CONSTRAINT order_payments_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_reviews order_reviews_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_reviews
    ADD CONSTRAINT order_reviews_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: orders orders_customer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_foreign FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- Name: passkeys passkeys_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passkeys
    ADD CONSTRAINT passkeys_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: products products_product_category_name_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_category_name_foreign FOREIGN KEY (product_category_name) REFERENCES public.product_category_translations(product_category_name) ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: febrihidayan
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict 9h6FdlIKauJD8BQbrUaHWG70dh3c0tZeubeWqyfpVGf4idHdB7BHtlDKdgszu7W

