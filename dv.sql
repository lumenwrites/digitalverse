--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO lumiverse_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO lumiverse_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO lumiverse_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO lumiverse_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO lumiverse_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO lumiverse_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: categories_category; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE categories_category (
    id integer NOT NULL,
    title character varying(64) NOT NULL,
    slug character varying(64) NOT NULL
);


ALTER TABLE public.categories_category OWNER TO lumiverse_user;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_id_seq OWNER TO lumiverse_user;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE categories_category_id_seq OWNED BY categories_category.id;


--
-- Name: comments_comment; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE comments_comment (
    id integer NOT NULL,
    body text NOT NULL,
    score integer NOT NULL,
    pub_date timestamp with time zone NOT NULL,
    author_id integer NOT NULL,
    parent_id integer,
    video_id integer
);


ALTER TABLE public.comments_comment OWNER TO lumiverse_user;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE comments_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_comment_id_seq OWNER TO lumiverse_user;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE comments_comment_id_seq OWNED BY comments_comment.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO lumiverse_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO lumiverse_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO lumiverse_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO lumiverse_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO lumiverse_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO lumiverse_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO lumiverse_user;

--
-- Name: hubs_hub; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE hubs_hub (
    id integer NOT NULL,
    title character varying(64) NOT NULL,
    slug character varying(64) NOT NULL,
    avatar character varying(100),
    background character varying(100),
    description text
);


ALTER TABLE public.hubs_hub OWNER TO lumiverse_user;

--
-- Name: hubs_hub_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE hubs_hub_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hubs_hub_id_seq OWNER TO lumiverse_user;

--
-- Name: hubs_hub_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE hubs_hub_id_seq OWNED BY hubs_hub.id;


--
-- Name: posts_image; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE posts_image (
    id integer NOT NULL,
    image character varying(100),
    post_id integer
);


ALTER TABLE public.posts_image OWNER TO lumiverse_user;

--
-- Name: posts_image_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE posts_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_image_id_seq OWNER TO lumiverse_user;

--
-- Name: posts_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE posts_image_id_seq OWNED BY posts_image.id;


--
-- Name: posts_post; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE posts_post (
    id integer NOT NULL,
    title character varying(256) NOT NULL,
    slug character varying(256) NOT NULL,
    published boolean NOT NULL,
    pub_date timestamp with time zone NOT NULL,
    image character varying(100),
    thumbnail character varying(100),
    description text,
    score integer NOT NULL,
    author_id integer NOT NULL,
    views integer NOT NULL,
    series_id integer
);


ALTER TABLE public.posts_post OWNER TO lumiverse_user;

--
-- Name: posts_post_categories; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE posts_post_categories (
    id integer NOT NULL,
    post_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.posts_post_categories OWNER TO lumiverse_user;

--
-- Name: posts_post_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE posts_post_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_post_categories_id_seq OWNER TO lumiverse_user;

--
-- Name: posts_post_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE posts_post_categories_id_seq OWNED BY posts_post_categories.id;


--
-- Name: posts_post_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE posts_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_post_id_seq OWNER TO lumiverse_user;

--
-- Name: posts_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE posts_post_id_seq OWNED BY posts_post.id;


--
-- Name: profiles_user; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE profiles_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    about text NOT NULL,
    website character varying(64) NOT NULL,
    karma integer NOT NULL,
    avatar character varying(100),
    background character varying(100),
    approved boolean NOT NULL,
    hidden boolean NOT NULL,
    youtube_channel character varying(128) NOT NULL,
    youtube_player boolean NOT NULL
);


ALTER TABLE public.profiles_user OWNER TO lumiverse_user;

--
-- Name: profiles_user_comments_upvoted; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE profiles_user_comments_upvoted (
    id integer NOT NULL,
    user_id integer NOT NULL,
    comment_id integer NOT NULL
);


ALTER TABLE public.profiles_user_comments_upvoted OWNER TO lumiverse_user;

--
-- Name: profiles_user_comments_upvoted_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE profiles_user_comments_upvoted_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_user_comments_upvoted_id_seq OWNER TO lumiverse_user;

--
-- Name: profiles_user_comments_upvoted_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE profiles_user_comments_upvoted_id_seq OWNED BY profiles_user_comments_upvoted.id;


--
-- Name: profiles_user_groups; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE profiles_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.profiles_user_groups OWNER TO lumiverse_user;

--
-- Name: profiles_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE profiles_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_user_groups_id_seq OWNER TO lumiverse_user;

--
-- Name: profiles_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE profiles_user_groups_id_seq OWNED BY profiles_user_groups.id;


--
-- Name: profiles_user_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE profiles_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_user_id_seq OWNER TO lumiverse_user;

--
-- Name: profiles_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE profiles_user_id_seq OWNED BY profiles_user.id;


--
-- Name: profiles_user_subscribed; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE profiles_user_subscribed (
    id integer NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.profiles_user_subscribed OWNER TO lumiverse_user;

--
-- Name: profiles_user_subscribed_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE profiles_user_subscribed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_user_subscribed_id_seq OWNER TO lumiverse_user;

--
-- Name: profiles_user_subscribed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE profiles_user_subscribed_id_seq OWNED BY profiles_user_subscribed.id;


--
-- Name: profiles_user_subscribed_series; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE profiles_user_subscribed_series (
    id integer NOT NULL,
    user_id integer NOT NULL,
    series_id integer NOT NULL
);


ALTER TABLE public.profiles_user_subscribed_series OWNER TO lumiverse_user;

--
-- Name: profiles_user_subscribed_series_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE profiles_user_subscribed_series_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_user_subscribed_series_id_seq OWNER TO lumiverse_user;

--
-- Name: profiles_user_subscribed_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE profiles_user_subscribed_series_id_seq OWNED BY profiles_user_subscribed_series.id;


--
-- Name: profiles_user_upvoted; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE profiles_user_upvoted (
    id integer NOT NULL,
    user_id integer NOT NULL,
    video_id integer NOT NULL
);


ALTER TABLE public.profiles_user_upvoted OWNER TO lumiverse_user;

--
-- Name: profiles_user_upvoted_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE profiles_user_upvoted_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_user_upvoted_id_seq OWNER TO lumiverse_user;

--
-- Name: profiles_user_upvoted_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE profiles_user_upvoted_id_seq OWNED BY profiles_user_upvoted.id;


--
-- Name: profiles_user_user_permissions; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE profiles_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.profiles_user_user_permissions OWNER TO lumiverse_user;

--
-- Name: profiles_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE profiles_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_user_user_permissions_id_seq OWNER TO lumiverse_user;

--
-- Name: profiles_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE profiles_user_user_permissions_id_seq OWNED BY profiles_user_user_permissions.id;


--
-- Name: series_series; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE series_series (
    id integer NOT NULL,
    title character varying(256) NOT NULL,
    slug character varying(256) NOT NULL,
    published boolean NOT NULL,
    pub_date timestamp with time zone NOT NULL,
    description text,
    score integer NOT NULL,
    views integer NOT NULL,
    author_id integer NOT NULL,
    background character varying(100),
    image character varying(100)
);


ALTER TABLE public.series_series OWNER TO lumiverse_user;

--
-- Name: series_series_categories; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE series_series_categories (
    id integer NOT NULL,
    series_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.series_series_categories OWNER TO lumiverse_user;

--
-- Name: series_series_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE series_series_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_series_categories_id_seq OWNER TO lumiverse_user;

--
-- Name: series_series_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE series_series_categories_id_seq OWNED BY series_series_categories.id;


--
-- Name: series_series_hubs; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE series_series_hubs (
    id integer NOT NULL,
    series_id integer NOT NULL,
    hub_id integer NOT NULL
);


ALTER TABLE public.series_series_hubs OWNER TO lumiverse_user;

--
-- Name: series_series_hubs_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE series_series_hubs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_series_hubs_id_seq OWNER TO lumiverse_user;

--
-- Name: series_series_hubs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE series_series_hubs_id_seq OWNED BY series_series_hubs.id;


--
-- Name: series_series_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE series_series_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.series_series_id_seq OWNER TO lumiverse_user;

--
-- Name: series_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE series_series_id_seq OWNED BY series_series.id;


--
-- Name: videos_video; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE videos_video (
    id integer NOT NULL,
    title character varying(256) NOT NULL,
    slug character varying(256) NOT NULL,
    published boolean NOT NULL,
    pub_date timestamp with time zone NOT NULL,
    video character varying(100),
    thumbnail character varying(100),
    description text,
    score integer NOT NULL,
    views integer NOT NULL,
    author_id integer NOT NULL,
    series_id integer,
    video_url character varying(256),
    digitalverse boolean NOT NULL
);


ALTER TABLE public.videos_video OWNER TO lumiverse_user;

--
-- Name: videos_video_categories; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE videos_video_categories (
    id integer NOT NULL,
    video_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.videos_video_categories OWNER TO lumiverse_user;

--
-- Name: videos_video_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE videos_video_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videos_video_categories_id_seq OWNER TO lumiverse_user;

--
-- Name: videos_video_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE videos_video_categories_id_seq OWNED BY videos_video_categories.id;


--
-- Name: videos_video_hubs; Type: TABLE; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE TABLE videos_video_hubs (
    id integer NOT NULL,
    video_id integer NOT NULL,
    hub_id integer NOT NULL
);


ALTER TABLE public.videos_video_hubs OWNER TO lumiverse_user;

--
-- Name: videos_video_hubs_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE videos_video_hubs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videos_video_hubs_id_seq OWNER TO lumiverse_user;

--
-- Name: videos_video_hubs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE videos_video_hubs_id_seq OWNED BY videos_video_hubs.id;


--
-- Name: videos_video_id_seq; Type: SEQUENCE; Schema: public; Owner: lumiverse_user
--

CREATE SEQUENCE videos_video_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videos_video_id_seq OWNER TO lumiverse_user;

--
-- Name: videos_video_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lumiverse_user
--

ALTER SEQUENCE videos_video_id_seq OWNED BY videos_video.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY categories_category ALTER COLUMN id SET DEFAULT nextval('categories_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY comments_comment ALTER COLUMN id SET DEFAULT nextval('comments_comment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY hubs_hub ALTER COLUMN id SET DEFAULT nextval('hubs_hub_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY posts_image ALTER COLUMN id SET DEFAULT nextval('posts_image_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY posts_post ALTER COLUMN id SET DEFAULT nextval('posts_post_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY posts_post_categories ALTER COLUMN id SET DEFAULT nextval('posts_post_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user ALTER COLUMN id SET DEFAULT nextval('profiles_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_comments_upvoted ALTER COLUMN id SET DEFAULT nextval('profiles_user_comments_upvoted_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_groups ALTER COLUMN id SET DEFAULT nextval('profiles_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_subscribed ALTER COLUMN id SET DEFAULT nextval('profiles_user_subscribed_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_subscribed_series ALTER COLUMN id SET DEFAULT nextval('profiles_user_subscribed_series_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_upvoted ALTER COLUMN id SET DEFAULT nextval('profiles_user_upvoted_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('profiles_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY series_series ALTER COLUMN id SET DEFAULT nextval('series_series_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY series_series_categories ALTER COLUMN id SET DEFAULT nextval('series_series_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY series_series_hubs ALTER COLUMN id SET DEFAULT nextval('series_series_hubs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY videos_video ALTER COLUMN id SET DEFAULT nextval('videos_video_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY videos_video_categories ALTER COLUMN id SET DEFAULT nextval('videos_video_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY videos_video_hubs ALTER COLUMN id SET DEFAULT nextval('videos_video_hubs_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add kv store	6	add_kvstore
17	Can change kv store	6	change_kvstore
18	Can delete kv store	6	delete_kvstore
19	Can add series	7	add_series
20	Can change series	7	change_series
21	Can delete series	7	delete_series
22	Can add category	8	add_category
23	Can change category	8	change_category
24	Can delete category	8	delete_category
25	Can add post	9	add_post
26	Can change post	9	change_post
27	Can delete post	9	delete_post
28	Can add image	10	add_image
29	Can change image	10	change_image
30	Can delete image	10	delete_image
31	Can add video	11	add_video
32	Can change video	11	change_video
33	Can delete video	11	delete_video
34	Can add user	12	add_user
35	Can change user	12	change_user
36	Can delete user	12	delete_user
37	Can add comment	13	add_comment
38	Can change comment	13	change_comment
39	Can delete comment	13	delete_comment
40	Can add hub	14	add_hub
41	Can change hub	14	change_hub
42	Can delete hub	14	delete_hub
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('auth_permission_id_seq', 42, true);


--
-- Data for Name: categories_category; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY categories_category (id, title, slug) FROM stdin;
7	Modeling	modeling
8	Rigging	rigging
9	Animation	animation
10	Rendering	rendering
\.


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('categories_category_id_seq', 10, true);


--
-- Data for Name: comments_comment; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY comments_comment (id, body, score, pub_date, author_id, parent_id, video_id) FROM stdin;
\.


--
-- Name: comments_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('comments_comment_id_seq', 11, true);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2016-03-08 06:58:23.202572-05	1	Expired	1	Added.	11	1
2	2016-03-08 11:12:01.762648-05	1	Expired	3		11	1
3	2016-03-08 11:12:01.772905-05	2	Necromancer	3		11	1
4	2016-03-08 11:12:01.777858-05	3	Necromancer	3		11	1
5	2016-03-08 11:14:07.996057-05	4	Necromancer	3		11	1
6	2016-03-08 11:14:55.986399-05	5	Necromancer	3		11	1
7	2016-03-08 12:13:58.230248-05	1	Animation	1	Added.	8	1
8	2016-03-08 12:14:06.60424-05	2	Comedy	1	Added.	8	1
9	2016-03-08 12:14:10.638035-05	2	Comedy	2	No fields changed.	8	1
10	2016-03-08 12:14:30.387576-05	3	Programming	1	Added.	8	1
11	2016-03-08 12:14:30.650248-05	4	Programming	1	Added.	8	1
12	2016-03-08 12:14:54.476468-05	3	Programming	3		8	1
13	2016-03-10 09:11:16.854049-05	5	Tutorials	1	Added.	8	1
14	2016-03-10 09:11:26.201031-05	6	Rationality	1	Added.	8	1
15	2016-03-10 10:04:44.59917-05	9	The Old Tower	1	Added.	11	1
16	2016-03-10 10:11:26.507993-05	9	The Old Tower	2	Changed video_url.	11	1
17	2016-03-12 17:07:09.892064-05	2	Orange Mind	2	Changed description.	7	1
18	2016-03-12 17:07:37.003118-05	3	Digital Verse	1	Added.	7	1
19	2016-03-12 17:10:02.755548-05	3	Digital Verse	2	Changed published.	7	1
20	2016-03-12 17:10:07.356294-05	2	Orange Mind	2	Changed published.	7	1
21	2016-03-12 18:15:43.779111-05	1	Science	1	Added.	14	1
22	2016-03-12 18:15:51.423134-05	2	Educational	1	Added.	14	1
23	2016-03-12 18:15:59.510271-05	3	Programming	1	Added.	14	1
24	2016-03-12 19:04:42.374712-05	2	Orange Mind	2	Changed score.	7	1
25	2016-03-14 13:57:28.418679-04	4	user1	2	Changed approved.	12	1
26	2016-03-14 16:16:02.949888-04	1	rayalez	2	Changed youtube_player.	12	1
27	2016-03-14 19:30:10.059908-04	1	rayalez	2	Changed youtube_player.	12	1
28	2016-03-15 16:08:11.347182-04	2	lumen	2	Changed approved.	12	1
29	2016-03-15 16:11:36.567-04	4	Anatomy	2	Changed published and description.	7	1
30	2016-03-15 16:14:13.504942-04	4	Anatomy	2	Changed image.	7	1
31	2016-03-16 12:17:30.429679-04	1	rayalez	2	Changed comments_upvoted.	12	1
32	2016-09-13 08:38:51.622399-04	8	Expired	3		11	1
33	2016-09-13 08:38:51.626908-04	9	The Old Tower	3		11	1
34	2016-09-13 08:38:51.62905-04	12	Emotional Intelligence 101	3		11	1
35	2016-09-13 08:39:16.79261-04	6	Rationality	3		8	1
36	2016-09-13 08:39:16.795291-04	5	Tutorials	3		8	1
37	2016-09-13 08:39:16.797395-04	4	Programming	3		8	1
38	2016-09-13 08:39:16.799374-04	2	Comedy	3		8	1
39	2016-09-13 08:39:16.801305-04	1	Animation	3		8	1
40	2016-09-13 08:41:53.327866-04	7	Modeling	1	Added.	8	1
41	2016-09-13 08:41:57.72962-04	8	Rigging	1	Added.	8	1
42	2016-09-13 08:42:02.782232-04	9	Animation	1	Added.	8	1
43	2016-09-13 08:42:07.465708-04	10	Rendering	1	Added.	8	1
44	2016-09-13 08:43:34.629281-04	4	Anatomy	3		7	1
45	2016-09-13 08:43:34.632094-04	3	Digital Verse	3		7	1
46	2016-09-13 08:43:34.634427-04	2	Orange Mind	3		7	1
47	2016-09-13 08:48:58.755165-04	5	Body Mechanics	1	Added.	7	1
48	2016-09-13 08:59:48.09605-04	3	Programming	3		14	1
49	2016-09-13 08:59:48.10144-04	2	Educational	3		14	1
50	2016-09-13 08:59:48.103551-04	1	Science	3		14	1
51	2016-09-13 08:59:57.512565-04	4	Modeling	1	Added.	14	1
52	2016-09-13 09:00:02.459462-04	5	Animation	1	Added.	14	1
53	2016-09-13 09:00:10.821635-04	6	Rigging	1	Added.	14	1
54	2016-09-13 09:00:16.861188-04	7	Rendering	1	Added.	14	1
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 54, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	thumbnail	kvstore
7	series	series
8	categories	category
9	posts	post
10	posts	image
11	videos	video
12	profiles	user
13	comments	comment
14	hubs	hub
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('django_content_type_id_seq', 14, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2016-03-08 06:56:19.856656-05
2	contenttypes	0002_remove_content_type_name	2016-03-08 06:56:19.889887-05
3	auth	0001_initial	2016-03-08 06:56:20.041978-05
4	auth	0002_alter_permission_name_max_length	2016-03-08 06:56:20.064826-05
5	auth	0003_alter_user_email_max_length	2016-03-08 06:56:20.13541-05
6	auth	0004_alter_user_username_opts	2016-03-08 06:56:20.161089-05
7	auth	0005_alter_user_last_login_null	2016-03-08 06:56:20.188106-05
8	auth	0006_require_contenttypes_0002	2016-03-08 06:56:20.193479-05
9	auth	0007_alter_validators_add_error_messages	2016-03-08 06:56:20.220908-05
10	profiles	0001_initial	2016-03-08 06:56:20.323449-05
11	admin	0001_initial	2016-03-08 06:56:20.392493-05
12	admin	0002_logentry_remove_auto_add	2016-03-08 06:56:20.436229-05
13	categories	0001_initial	2016-03-08 06:56:20.464398-05
14	posts	0001_initial	2016-03-08 06:56:20.535034-05
15	posts	0002_category	2016-03-08 06:56:20.567825-05
16	posts	0003_post_categories	2016-03-08 06:56:20.666775-05
17	posts	0004_post_views	2016-03-08 06:56:20.861718-05
18	comments	0001_initial	2016-03-08 06:56:20.953647-05
19	posts	0005_auto_20160125_0327	2016-03-08 06:56:21.010592-05
20	series	0001_initial	2016-03-08 06:56:21.162075-05
21	posts	0006_auto_20160125_0813	2016-03-08 06:56:21.361498-05
22	posts	0007_post_series	2016-03-08 06:56:21.438447-05
23	posts	0008_image	2016-03-08 06:56:21.519321-05
24	profiles	0002_auto_20160121_0721	2016-03-08 06:56:21.731269-05
25	profiles	0003_auto_20160122_2008	2016-03-08 06:56:21.866073-05
26	profiles	0004_user_subscribed_series	2016-03-08 06:56:21.97569-05
27	series	0002_series_background	2016-03-08 06:56:22.070865-05
28	series	0003_auto_20160125_1059	2016-03-08 06:56:22.272009-05
29	series	0004_auto_20160125_1233	2016-03-08 06:56:22.419215-05
30	sessions	0001_initial	2016-03-08 06:56:22.466989-05
31	videos	0001_initial	2016-03-08 06:56:22.622959-05
32	videos	0002_auto_20160310_1503	2016-03-10 10:04:42.68321-05
33	videos	0003_auto_20160311_1357	2016-03-11 08:57:43.016522-05
34	comments	0002_auto_20160311_1357	2016-03-11 08:57:43.297638-05
35	profiles	0005_auto_20160311_1552	2016-03-11 10:52:30.732623-05
36	series	0005_auto_20160311_1552	2016-03-11 10:52:30.832686-05
37	profiles	0006_auto_20160311_1556	2016-03-11 10:57:05.54455-05
38	profiles	0007_auto_20160312_2124	2016-03-12 16:24:26.579399-05
39	hubs	0001_initial	2016-03-12 17:56:24.236428-05
40	series	0006_series_hubs	2016-03-12 18:08:39.75843-05
41	videos	0004_video_hub	2016-03-12 18:08:39.870633-05
42	videos	0005_auto_20160312_2313	2016-03-12 18:13:17.316708-05
43	videos	0006_auto_20160312_2325	2016-03-12 18:26:01.599017-05
44	profiles	0008_user_youtube_channel	2016-03-12 22:30:03.51068-05
45	profiles	0009_user_youtube_player	2016-03-14 16:07:43.312779-04
46	profiles	0010_user_comments_upvoted	2016-03-16 12:01:39.086946-04
47	videos	0007_video_digitalverse	2016-08-30 02:32:12.458871-04
48	videos	0008_auto_20160913_1600	2016-09-13 12:00:14.763972-04
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('django_migrations_id_seq', 48, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
rw19t3nubp301mtpwsengfotosnqnthi	ZGFhY2UzM2FhZGY5NjAyN2QzMDk1MzMxYWI1NTRhYzAxY2M0NDM1NDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2hhc2giOiJlYTY5M2RlYjJjZDE4YWVjYmYwNzg4NDcxZTgyNjRmOGQ4MjY2YWJhIn0=	2016-03-22 07:57:37.518533-04
nb0wf5fi0rrf25x7yfrv1amsjqzs7jkl	MzM4Y2FjMDc5NzcyNDFmZmE2NGU4NmUwNzRiMDc2OWYyNWNhODk0MTp7Il9hdXRoX3VzZXJfaGFzaCI6ImExZjc0NzcwNWI1MDgyZGE5NWFiMzdkZjkzYzZiYzBmNjc2ZTNmZTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=	2016-03-25 15:46:17.776984-04
1ldi7ts239pin63jmt2zmej69v0yhilz	MTQyMjM0ODcyMDBlYzYzZTlmNjkxOWE0ZTA1NjU4ZTMzYWQzNDE5ZTp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9oYXNoIjoiMDljMDA2MThhYzRlMmRiZWE3MDM1MDFjMDVhMjQ0MmM2Zjk2NWM1YSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2016-03-28 13:55:58.241436-04
7mhuuusq8fq2om8n8ximb2lb5jnrprb7	ZmQ2ZDFkYWM1MTI5ZmJlODY2OGNjZjlhNDBiMWVlNTEzZGYwODY3MTp7Il9hdXRoX3VzZXJfaGFzaCI6ImVhNjkzZGViMmNkMThhZWNiZjA3ODg0NzFlODI2NGY4ZDgyNjZhYmEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=	2016-04-12 08:25:45.282144-04
y2rcbp10ksc1y2fl31u5ynbw67fync3b	MGRhZGVkMTNiNjQ4MjA3ZWFlYjgwYmNiODc5NmE5OGJmZDIwNTdkZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlYTY5M2RlYjJjZDE4YWVjYmYwNzg4NDcxZTgyNjRmOGQ4MjY2YWJhIn0=	2016-08-01 18:26:54.278527-04
peymdztpyuqh14ww538fqk79imlaaia3	MDg1ODkwMDU4NTVkYjlhMGUzYzFlNjA5YTg4MjA4ODE5MzNlMDI0Njp7Il9hdXRoX3VzZXJfaGFzaCI6ImVhNjkzZGViMmNkMThhZWNiZjA3ODg0NzFlODI2NGY4ZDgyNjZhYmEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=	2016-09-27 08:38:37.213825-04
\.


--
-- Data for Name: hubs_hub; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY hubs_hub (id, title, slug, avatar, background, description) FROM stdin;
4	Modeling	modeling			
5	Animation	animation			
6	Rigging	rigging			
7	Rendering	rendering			
\.


--
-- Name: hubs_hub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('hubs_hub_id_seq', 7, true);


--
-- Data for Name: posts_image; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY posts_image (id, image, post_id) FROM stdin;
\.


--
-- Name: posts_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('posts_image_id_seq', 1, false);


--
-- Data for Name: posts_post; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY posts_post (id, title, slug, published, pub_date, image, thumbnail, description, score, author_id, views, series_id) FROM stdin;
\.


--
-- Data for Name: posts_post_categories; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY posts_post_categories (id, post_id, category_id) FROM stdin;
\.


--
-- Name: posts_post_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('posts_post_categories_id_seq', 1, false);


--
-- Name: posts_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('posts_post_id_seq', 1, false);


--
-- Data for Name: profiles_user; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY profiles_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, about, website, karma, avatar, background, approved, hidden, youtube_channel, youtube_player) FROM stdin;
3	pbkdf2_sha256$24000$8SGPMod3dRNx$mt6z+Ug29Hj7UoR6mMwerdkVPhPZWAn1RkueX9mPM8s=	2016-03-14 13:16:31.512928-04	f	lumenwrites				f	t	2016-03-14 13:16:31.279693-04			0			t	f		f
4	pbkdf2_sha256$24000$NMZTjVEHowLR$vdQ+kE1s7jZAYG0NgUW9GryEFRa5q/86YZwCjsJenk0=	2016-03-14 13:55:58-04	f	user1				f	t	2016-03-14 13:55:58-04			0			f	f		f
2	pbkdf2_sha256$24000$r4L6yI9gn9Qv$t/1a6fA514biK9BWdTAAmxPhA60uCtqa8MECD/Gc6vY=	2016-03-11 14:46:17-05	f	lumen				f	t	2016-03-11 14:46:17-05	sd		2		users/backgrounds/proko-logo.png	t	f		f
1	pbkdf2_sha256$24000$8mTojPgCj9O1$JPvNLUlk070jUNCUbWxXpKlznnYXHsJhClWrvjDJXHM=	2016-09-13 08:38:37.20496-04	t	rayalez			raymestalez@gmail.com	t	t	2016-03-08 06:57:29-05	About me.	http://orangemind.io	2	users/avatars/signature_5CQDbDm.png	users/backgrounds/conjecture-bg3.png	f	f	https://www.youtube.com/channel/UC_l3Sk5Lu4qmiASeG11VsrA	f
\.


--
-- Data for Name: profiles_user_comments_upvoted; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY profiles_user_comments_upvoted (id, user_id, comment_id) FROM stdin;
\.


--
-- Name: profiles_user_comments_upvoted_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('profiles_user_comments_upvoted_id_seq', 13, true);


--
-- Data for Name: profiles_user_groups; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY profiles_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: profiles_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('profiles_user_groups_id_seq', 1, false);


--
-- Name: profiles_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('profiles_user_id_seq', 4, true);


--
-- Data for Name: profiles_user_subscribed; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY profiles_user_subscribed (id, from_user_id, to_user_id) FROM stdin;
1	3	1
\.


--
-- Name: profiles_user_subscribed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('profiles_user_subscribed_id_seq', 2, true);


--
-- Data for Name: profiles_user_subscribed_series; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY profiles_user_subscribed_series (id, user_id, series_id) FROM stdin;
\.


--
-- Name: profiles_user_subscribed_series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('profiles_user_subscribed_series_id_seq', 1, false);


--
-- Data for Name: profiles_user_upvoted; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY profiles_user_upvoted (id, user_id, video_id) FROM stdin;
\.


--
-- Name: profiles_user_upvoted_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('profiles_user_upvoted_id_seq', 3, true);


--
-- Data for Name: profiles_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY profiles_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: profiles_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('profiles_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: series_series; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY series_series (id, title, slug, published, pub_date, description, score, views, author_id, background, image) FROM stdin;
5	Body Mechanics	body-mechanics	f	2016-09-13 08:48:58.748504-04		0	0	3		
\.


--
-- Data for Name: series_series_categories; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY series_series_categories (id, series_id, category_id) FROM stdin;
\.


--
-- Name: series_series_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('series_series_categories_id_seq', 5, true);


--
-- Data for Name: series_series_hubs; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY series_series_hubs (id, series_id, hub_id) FROM stdin;
\.


--
-- Name: series_series_hubs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('series_series_hubs_id_seq', 1, true);


--
-- Name: series_series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('series_series_id_seq', 5, true);


--
-- Data for Name: videos_video; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY videos_video (id, title, slug, published, pub_date, video, thumbnail, description, score, views, author_id, series_id, video_url, digitalverse) FROM stdin;
14	Modeling 3D Cartoon Character Topology	modeling-3d-cartoon-character-topology	t	2016-09-13 08:59:19.429264-04			Download all the steps [here](/media/files/toon-character-modeling.zip).	0	0	1	\N	https://www.youtube.com/watch?v=ienREUOX5BA	f
18	Bouncing Ball #2	bouncing-ball-2	t	2016-09-13 09:32:14.812971-04			[Ball Rig](/media/files/ball_rig.hda).\r\n\r\n[Vertical Bounce](/media/files/ball_animation_up_down.hip).\r\n\r\n[Final Animation](/media/files/ball_animation_up_down.hip).	0	30	1	\N	https://www.youtube.com/watch?v=OAWjK2fnM0E	f
15	Creating a procedural gear in SideFX Houdini	creating-a-procedural-gear-in-sidefx-houdini	t	2016-09-13 09:23:31.137412-04			Download the example scene [here](/media/files/gear.hip).	0	0	1	\N	https://www.youtube.com/watch?v=GO3eCxRJCig	f
16	Creating a simple bouncing ball rig in Houdini	creating-a-simple-bouncing-ball-rig-in-houdini	t	2016-09-13 09:26:09.898279-04			Download rig [here](/media/files/ball_rig.hda).	0	0	1	\N	https://www.youtube.com/watch?v=k85jrTriNr4	f
17	Bouncing Ball #1	bouncing-ball-1	t	2016-09-13 09:29:53.667455-04			Download rig [here](/media/files/ball_rig.hda).\r\n\r\nDownload the scene [here](/media/files/ball_animation_up_down.hip).	0	0	1	\N	https://www.youtube.com/watch?v=PJ3szkBVuJs	f
\.


--
-- Data for Name: videos_video_categories; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY videos_video_categories (id, video_id, category_id) FROM stdin;
\.


--
-- Name: videos_video_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('videos_video_categories_id_seq', 7, true);


--
-- Data for Name: videos_video_hubs; Type: TABLE DATA; Schema: public; Owner: lumiverse_user
--

COPY videos_video_hubs (id, video_id, hub_id) FROM stdin;
3	14	4
4	15	6
5	16	6
6	17	5
7	18	5
\.


--
-- Name: videos_video_hubs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('videos_video_hubs_id_seq', 7, true);


--
-- Name: videos_video_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lumiverse_user
--

SELECT pg_catalog.setval('videos_video_id_seq', 18, true);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: categories_category_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY categories_category
    ADD CONSTRAINT categories_category_pkey PRIMARY KEY (id);


--
-- Name: comments_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY comments_comment
    ADD CONSTRAINT comments_comment_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: hubs_hub_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY hubs_hub
    ADD CONSTRAINT hubs_hub_pkey PRIMARY KEY (id);


--
-- Name: posts_image_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY posts_image
    ADD CONSTRAINT posts_image_pkey PRIMARY KEY (id);


--
-- Name: posts_post_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY posts_post_categories
    ADD CONSTRAINT posts_post_categories_pkey PRIMARY KEY (id);


--
-- Name: posts_post_categories_post_id_00bce8d0_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY posts_post_categories
    ADD CONSTRAINT posts_post_categories_post_id_00bce8d0_uniq UNIQUE (post_id, category_id);


--
-- Name: posts_post_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY posts_post
    ADD CONSTRAINT posts_post_pkey PRIMARY KEY (id);


--
-- Name: profiles_user_comments_upvoted_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_comments_upvoted
    ADD CONSTRAINT profiles_user_comments_upvoted_pkey PRIMARY KEY (id);


--
-- Name: profiles_user_comments_upvoted_user_id_dd9a84f1_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_comments_upvoted
    ADD CONSTRAINT profiles_user_comments_upvoted_user_id_dd9a84f1_uniq UNIQUE (user_id, comment_id);


--
-- Name: profiles_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_groups
    ADD CONSTRAINT profiles_user_groups_pkey PRIMARY KEY (id);


--
-- Name: profiles_user_groups_user_id_8abc21ba_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_groups
    ADD CONSTRAINT profiles_user_groups_user_id_8abc21ba_uniq UNIQUE (user_id, group_id);


--
-- Name: profiles_user_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user
    ADD CONSTRAINT profiles_user_pkey PRIMARY KEY (id);


--
-- Name: profiles_user_subscribed_from_user_id_8a7b490f_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_subscribed
    ADD CONSTRAINT profiles_user_subscribed_from_user_id_8a7b490f_uniq UNIQUE (from_user_id, to_user_id);


--
-- Name: profiles_user_subscribed_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_subscribed
    ADD CONSTRAINT profiles_user_subscribed_pkey PRIMARY KEY (id);


--
-- Name: profiles_user_subscribed_series_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_subscribed_series
    ADD CONSTRAINT profiles_user_subscribed_series_pkey PRIMARY KEY (id);


--
-- Name: profiles_user_subscribed_series_user_id_a2996201_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_subscribed_series
    ADD CONSTRAINT profiles_user_subscribed_series_user_id_a2996201_uniq UNIQUE (user_id, series_id);


--
-- Name: profiles_user_upvoted_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_upvoted
    ADD CONSTRAINT profiles_user_upvoted_pkey PRIMARY KEY (id);


--
-- Name: profiles_user_upvoted_user_id_26b1d235_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_upvoted
    ADD CONSTRAINT profiles_user_upvoted_user_id_26b1d235_uniq UNIQUE (user_id, video_id);


--
-- Name: profiles_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_user_permissions
    ADD CONSTRAINT profiles_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: profiles_user_user_permissions_user_id_d7ec8e00_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user_user_permissions
    ADD CONSTRAINT profiles_user_user_permissions_user_id_d7ec8e00_uniq UNIQUE (user_id, permission_id);


--
-- Name: profiles_user_username_key; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY profiles_user
    ADD CONSTRAINT profiles_user_username_key UNIQUE (username);


--
-- Name: series_series_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY series_series_categories
    ADD CONSTRAINT series_series_categories_pkey PRIMARY KEY (id);


--
-- Name: series_series_categories_series_id_ce3742bc_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY series_series_categories
    ADD CONSTRAINT series_series_categories_series_id_ce3742bc_uniq UNIQUE (series_id, category_id);


--
-- Name: series_series_hubs_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY series_series_hubs
    ADD CONSTRAINT series_series_hubs_pkey PRIMARY KEY (id);


--
-- Name: series_series_hubs_series_id_45d70178_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY series_series_hubs
    ADD CONSTRAINT series_series_hubs_series_id_45d70178_uniq UNIQUE (series_id, hub_id);


--
-- Name: series_series_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY series_series
    ADD CONSTRAINT series_series_pkey PRIMARY KEY (id);


--
-- Name: videos_video_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY videos_video_categories
    ADD CONSTRAINT videos_video_categories_pkey PRIMARY KEY (id);


--
-- Name: videos_video_categories_video_id_3aead81e_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY videos_video_categories
    ADD CONSTRAINT videos_video_categories_video_id_3aead81e_uniq UNIQUE (video_id, category_id);


--
-- Name: videos_video_hubs_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY videos_video_hubs
    ADD CONSTRAINT videos_video_hubs_pkey PRIMARY KEY (id);


--
-- Name: videos_video_hubs_video_id_c57f2223_uniq; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY videos_video_hubs
    ADD CONSTRAINT videos_video_hubs_video_id_c57f2223_uniq UNIQUE (video_id, hub_id);


--
-- Name: videos_video_pkey; Type: CONSTRAINT; Schema: public; Owner: lumiverse_user; Tablespace: 
--

ALTER TABLE ONLY videos_video
    ADD CONSTRAINT videos_video_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: categories_category_2dbcba41; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX categories_category_2dbcba41 ON categories_category USING btree (slug);


--
-- Name: categories_category_slug_6fddebb1_like; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX categories_category_slug_6fddebb1_like ON categories_category USING btree (slug varchar_pattern_ops);


--
-- Name: comments_comment_4f331e2f; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX comments_comment_4f331e2f ON comments_comment USING btree (author_id);


--
-- Name: comments_comment_6be37982; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX comments_comment_6be37982 ON comments_comment USING btree (parent_id);


--
-- Name: comments_comment_b58b747e; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX comments_comment_b58b747e ON comments_comment USING btree (video_id);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: hubs_hub_2dbcba41; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX hubs_hub_2dbcba41 ON hubs_hub USING btree (slug);


--
-- Name: hubs_hub_slug_dbd6a2ee_like; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX hubs_hub_slug_dbd6a2ee_like ON hubs_hub USING btree (slug varchar_pattern_ops);


--
-- Name: posts_image_f3aa1999; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX posts_image_f3aa1999 ON posts_image USING btree (post_id);


--
-- Name: posts_post_2dbcba41; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX posts_post_2dbcba41 ON posts_post USING btree (slug);


--
-- Name: posts_post_4f331e2f; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX posts_post_4f331e2f ON posts_post USING btree (author_id);


--
-- Name: posts_post_a08cee2d; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX posts_post_a08cee2d ON posts_post USING btree (series_id);


--
-- Name: posts_post_categories_b583a629; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX posts_post_categories_b583a629 ON posts_post_categories USING btree (category_id);


--
-- Name: posts_post_categories_f3aa1999; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX posts_post_categories_f3aa1999 ON posts_post_categories USING btree (post_id);


--
-- Name: posts_post_slug_6e9097e5_like; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX posts_post_slug_6e9097e5_like ON posts_post USING btree (slug varchar_pattern_ops);


--
-- Name: profiles_user_comments_upvoted_69b97d17; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_comments_upvoted_69b97d17 ON profiles_user_comments_upvoted USING btree (comment_id);


--
-- Name: profiles_user_comments_upvoted_e8701ad4; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_comments_upvoted_e8701ad4 ON profiles_user_comments_upvoted USING btree (user_id);


--
-- Name: profiles_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_groups_0e939a4f ON profiles_user_groups USING btree (group_id);


--
-- Name: profiles_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_groups_e8701ad4 ON profiles_user_groups USING btree (user_id);


--
-- Name: profiles_user_subscribed_63add04c; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_subscribed_63add04c ON profiles_user_subscribed USING btree (to_user_id);


--
-- Name: profiles_user_subscribed_6b4f059f; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_subscribed_6b4f059f ON profiles_user_subscribed USING btree (from_user_id);


--
-- Name: profiles_user_subscribed_series_a08cee2d; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_subscribed_series_a08cee2d ON profiles_user_subscribed_series USING btree (series_id);


--
-- Name: profiles_user_subscribed_series_e8701ad4; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_subscribed_series_e8701ad4 ON profiles_user_subscribed_series USING btree (user_id);


--
-- Name: profiles_user_upvoted_e8701ad4; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_upvoted_e8701ad4 ON profiles_user_upvoted USING btree (user_id);


--
-- Name: profiles_user_upvoted_f3aa1999; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_upvoted_f3aa1999 ON profiles_user_upvoted USING btree (video_id);


--
-- Name: profiles_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_user_permissions_8373b171 ON profiles_user_user_permissions USING btree (permission_id);


--
-- Name: profiles_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_user_permissions_e8701ad4 ON profiles_user_user_permissions USING btree (user_id);


--
-- Name: profiles_user_username_5357bba6_like; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX profiles_user_username_5357bba6_like ON profiles_user USING btree (username varchar_pattern_ops);


--
-- Name: series_series_2dbcba41; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX series_series_2dbcba41 ON series_series USING btree (slug);


--
-- Name: series_series_4f331e2f; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX series_series_4f331e2f ON series_series USING btree (author_id);


--
-- Name: series_series_categories_a08cee2d; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX series_series_categories_a08cee2d ON series_series_categories USING btree (series_id);


--
-- Name: series_series_categories_b583a629; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX series_series_categories_b583a629 ON series_series_categories USING btree (category_id);


--
-- Name: series_series_hubs_97469368; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX series_series_hubs_97469368 ON series_series_hubs USING btree (hub_id);


--
-- Name: series_series_hubs_a08cee2d; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX series_series_hubs_a08cee2d ON series_series_hubs USING btree (series_id);


--
-- Name: series_series_slug_2bafa759_like; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX series_series_slug_2bafa759_like ON series_series USING btree (slug varchar_pattern_ops);


--
-- Name: videos_video_2dbcba41; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX videos_video_2dbcba41 ON videos_video USING btree (slug);


--
-- Name: videos_video_4f331e2f; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX videos_video_4f331e2f ON videos_video USING btree (author_id);


--
-- Name: videos_video_a08cee2d; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX videos_video_a08cee2d ON videos_video USING btree (series_id);


--
-- Name: videos_video_categories_b583a629; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX videos_video_categories_b583a629 ON videos_video_categories USING btree (category_id);


--
-- Name: videos_video_categories_b58b747e; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX videos_video_categories_b58b747e ON videos_video_categories USING btree (video_id);


--
-- Name: videos_video_hubs_97469368; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX videos_video_hubs_97469368 ON videos_video_hubs USING btree (hub_id);


--
-- Name: videos_video_hubs_b58b747e; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX videos_video_hubs_b58b747e ON videos_video_hubs USING btree (video_id);


--
-- Name: videos_video_slug_ef302921_like; Type: INDEX; Schema: public; Owner: lumiverse_user; Tablespace: 
--

CREATE INDEX videos_video_slug_ef302921_like ON videos_video USING btree (slug varchar_pattern_ops);


--
-- Name: auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: comments_comment_author_id_334ce9e2_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY comments_comment
    ADD CONSTRAINT comments_comment_author_id_334ce9e2_fk_profiles_user_id FOREIGN KEY (author_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: comments_comment_parent_id_3e0802fb_fk_comments_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY comments_comment
    ADD CONSTRAINT comments_comment_parent_id_3e0802fb_fk_comments_comment_id FOREIGN KEY (parent_id) REFERENCES comments_comment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: comments_comment_video_id_fe17644e_fk_videos_video_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY comments_comment
    ADD CONSTRAINT comments_comment_video_id_fe17644e_fk_videos_video_id FOREIGN KEY (video_id) REFERENCES videos_video(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_c564eba6_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_profiles_user_id FOREIGN KEY (user_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posts_image_post_id_6ed5e391_fk_posts_post_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY posts_image
    ADD CONSTRAINT posts_image_post_id_6ed5e391_fk_posts_post_id FOREIGN KEY (post_id) REFERENCES posts_post(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posts_post_author_id_fe5487bf_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY posts_post
    ADD CONSTRAINT posts_post_author_id_fe5487bf_fk_profiles_user_id FOREIGN KEY (author_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posts_post_categories_post_id_0ca7af15_fk_posts_post_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY posts_post_categories
    ADD CONSTRAINT posts_post_categories_post_id_0ca7af15_fk_posts_post_id FOREIGN KEY (post_id) REFERENCES posts_post(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: posts_post_series_id_c753ac43_fk_series_series_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY posts_post
    ADD CONSTRAINT posts_post_series_id_c753ac43_fk_series_series_id FOREIGN KEY (series_id) REFERENCES series_series(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_commen_comment_id_fa32815c_fk_comments_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_comments_upvoted
    ADD CONSTRAINT profiles_user_commen_comment_id_fa32815c_fk_comments_comment_id FOREIGN KEY (comment_id) REFERENCES comments_comment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_comments_upv_user_id_08a35d0f_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_comments_upvoted
    ADD CONSTRAINT profiles_user_comments_upv_user_id_08a35d0f_fk_profiles_user_id FOREIGN KEY (user_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_groups_group_id_352908a1_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_groups
    ADD CONSTRAINT profiles_user_groups_group_id_352908a1_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_groups_user_id_4d7ad1f7_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_groups
    ADD CONSTRAINT profiles_user_groups_user_id_4d7ad1f7_fk_profiles_user_id FOREIGN KEY (user_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_subscri_from_user_id_30d08a66_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_subscribed
    ADD CONSTRAINT profiles_user_subscri_from_user_id_30d08a66_fk_profiles_user_id FOREIGN KEY (from_user_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_subscribe_to_user_id_5e99aa02_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_subscribed
    ADD CONSTRAINT profiles_user_subscribe_to_user_id_5e99aa02_fk_profiles_user_id FOREIGN KEY (to_user_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_subscribed_s_user_id_113be17c_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_subscribed_series
    ADD CONSTRAINT profiles_user_subscribed_s_user_id_113be17c_fk_profiles_user_id FOREIGN KEY (user_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_subscribed_series_id_370cc91c_fk_series_series_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_subscribed_series
    ADD CONSTRAINT profiles_user_subscribed_series_id_370cc91c_fk_series_series_id FOREIGN KEY (series_id) REFERENCES series_series(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_upvoted_user_id_d04395a1_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_upvoted
    ADD CONSTRAINT profiles_user_upvoted_user_id_d04395a1_fk_profiles_user_id FOREIGN KEY (user_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_upvoted_video_id_245c6c2f_fk_videos_video_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_upvoted
    ADD CONSTRAINT profiles_user_upvoted_video_id_245c6c2f_fk_videos_video_id FOREIGN KEY (video_id) REFERENCES videos_video(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_user_permiss_user_id_d22af5be_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_user_permissions
    ADD CONSTRAINT profiles_user_user_permiss_user_id_d22af5be_fk_profiles_user_id FOREIGN KEY (user_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: profiles_user_user_permission_id_11ba56f0_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY profiles_user_user_permissions
    ADD CONSTRAINT profiles_user_user_permission_id_11ba56f0_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: series_series_author_id_abb41449_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY series_series
    ADD CONSTRAINT series_series_author_id_abb41449_fk_profiles_user_id FOREIGN KEY (author_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: series_series_ca_category_id_42b2e47d_fk_categories_category_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY series_series_categories
    ADD CONSTRAINT series_series_ca_category_id_42b2e47d_fk_categories_category_id FOREIGN KEY (category_id) REFERENCES categories_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: series_series_categories_series_id_3c58b10f_fk_series_series_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY series_series_categories
    ADD CONSTRAINT series_series_categories_series_id_3c58b10f_fk_series_series_id FOREIGN KEY (series_id) REFERENCES series_series(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: series_series_hubs_hub_id_cbe06224_fk_hubs_hub_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY series_series_hubs
    ADD CONSTRAINT series_series_hubs_hub_id_cbe06224_fk_hubs_hub_id FOREIGN KEY (hub_id) REFERENCES hubs_hub(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: series_series_hubs_series_id_9d260964_fk_series_series_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY series_series_hubs
    ADD CONSTRAINT series_series_hubs_series_id_9d260964_fk_series_series_id FOREIGN KEY (series_id) REFERENCES series_series(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: videos_video_author_id_cb8e1e63_fk_profiles_user_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY videos_video
    ADD CONSTRAINT videos_video_author_id_cb8e1e63_fk_profiles_user_id FOREIGN KEY (author_id) REFERENCES profiles_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: videos_video_cat_category_id_7e04058d_fk_categories_category_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY videos_video_categories
    ADD CONSTRAINT videos_video_cat_category_id_7e04058d_fk_categories_category_id FOREIGN KEY (category_id) REFERENCES categories_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: videos_video_categories_video_id_65ca1df7_fk_videos_video_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY videos_video_categories
    ADD CONSTRAINT videos_video_categories_video_id_65ca1df7_fk_videos_video_id FOREIGN KEY (video_id) REFERENCES videos_video(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: videos_video_hubs_hub_id_ed6c97b2_fk_hubs_hub_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY videos_video_hubs
    ADD CONSTRAINT videos_video_hubs_hub_id_ed6c97b2_fk_hubs_hub_id FOREIGN KEY (hub_id) REFERENCES hubs_hub(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: videos_video_hubs_video_id_e0f4d06c_fk_videos_video_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY videos_video_hubs
    ADD CONSTRAINT videos_video_hubs_video_id_e0f4d06c_fk_videos_video_id FOREIGN KEY (video_id) REFERENCES videos_video(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: videos_video_series_id_dc7c7322_fk_series_series_id; Type: FK CONSTRAINT; Schema: public; Owner: lumiverse_user
--

ALTER TABLE ONLY videos_video
    ADD CONSTRAINT videos_video_series_id_dc7c7322_fk_series_series_id FOREIGN KEY (series_id) REFERENCES series_series(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

