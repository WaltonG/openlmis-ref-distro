
-- Olmis create table statements
-- Created by Craig Appl (cappl@ona.io)
-- Modified by A. Maritim (amaritim@ona.io) and J. Wambere (jwambere@ona.io)
-- Last Updated 24 September 2018
--

--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';

--
-- Name: commodity_types; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE commodity_types (
    id uuid NOT NULL UNIQUE,
    name character varying(255),
    classificationsystem character varying(255),
    classificationid character varying(255),
    parentid uuid
);


ALTER TABLE commodity_types OWNER TO postgres;

--
-- Name: facilities; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE facilities (
    id uuid NOT NULL UNIQUE,
    code character varying(255),
    name character varying(255),
    status boolean,
    enabled boolean,
    type character varying(255),
    operator_code character varying(255),
    operator_name character varying(255),
    operator_id character varying(255),
    district character varying(255),
    region character varying(255),
    country character varying(255),
    golivedate date,
    godowndate date,
    openlmisaccessible boolean,
    comment text,
    description text,
    extradata json,
    location character varying(255)
);


ALTER TABLE facilities OWNER TO postgres;

--
-- Name: facility_operators; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE facility_operators (
    id uuid NOT NULL UNIQUE,
    code text,
    description text,
    displayorder integer,
    name character varying(255)
);


ALTER TABLE facility_operators OWNER TO postgres;

--
-- Name: ideal_stock_amounts; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE ideal_stock_amounts (
    id uuid NOT NULL UNIQUE,
    facilityid uuid,
    processingperiodid uuid,
    amount integer,
    commoditytypeid uuid
);


ALTER TABLE ideal_stock_amounts OWNER TO postgres;

--
-- Name: lots; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE lots (
    id uuid NOT NULL UNIQUE,
    lotcode character varying(255),
    expirationdate date,
    manufacturedate date,
    tradeitemid uuid,
    active boolean
);


ALTER TABLE lots OWNER TO postgres;

--
-- Name: orderables; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE orderables (
    id uuid NOT NULL UNIQUE,
    code character varying(255),
    fullproductname character varying(255),
    packroundingthreshold bigint,
    netcontent bigint,
    roundtozero boolean,
    description character varying(255),
    programid character varying(255),
    orderabledisplaydategoryid character varying(255),
    orderablecategorydisplayname character varying(255),
    orderablecategorydisplayorder int,
    active boolean,
    fullsupply boolean,
    displayorder int,
    dosesperpatient int,
    priceperpack double precision,
    tradeitemid character varying(255),
    extradata json
);


ALTER TABLE orderables OWNER TO postgres;

--
-- Name: processing_periods; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE processing_periods (
    id uuid NOT NULL UNIQUE,
    description text,
    enddate date,
    name character varying(255),
    startdate date,
    processingscheduleid uuid
);


ALTER TABLE processing_periods OWNER TO postgres;

--
-- Name: program_orderables; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE program_orderables (
    id uuid NOT NULL UNIQUE,
    active boolean,
    displayorder integer,
    dosesperpatient integer,
    fullsupply boolean,
    priceperpack numeric(19,2),
    orderabledisplaycategoryid uuid,
    orderableid uuid,
    programid uuid
);


ALTER TABLE program_orderables OWNER TO postgres;

--
-- Name: programs; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE programs (
    id uuid NOT NULL UNIQUE,
    active boolean,
    code character varying(255),
    description text,
    name text,
    periodsskippable boolean,
    shownonfullsupplytab boolean,
    enabledatephysicalstockcountcompleted boolean,
    skipauthorization boolean DEFAULT false
);


ALTER TABLE programs OWNER TO postgres;

--
-- Name: requisition_group_members; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE requisition_group_members (
    requisitiongroupid uuid NOT NULL,
    facilityid uuid
);


ALTER TABLE requisition_group_members OWNER TO postgres;

--
-- Name: requisition_group_program_schedules; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE requisition_group_program_schedules (
    id uuid NOT NULL UNIQUE,
    directdelivery boolean,
    dropofffacilityid uuid,
    processingscheduleid uuid,
    programid uuid,
    requisitiongroupid uuid
);


ALTER TABLE requisition_group_program_schedules OWNER TO postgres;

--
-- Name: supported_programs; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE supported_programs (
    active boolean NOT NULL,
    startdate date,
    facilityid uuid,
    programid uuid,
    locallyfulfilled boolean DEFAULT false
);


ALTER TABLE supported_programs OWNER TO postgres;

--
-- Name: trade_item_classifications; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE trade_item_classifications (
    id uuid NOT NULL UNIQUE,
    classificationsystem character varying(255),
    classificationid character varying(255),
    tradeitemid uuid
);


ALTER TABLE trade_item_classifications OWNER TO postgres;

--
-- Name: trade_items; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE trade_items (
    id uuid NOT NULL UNIQUE,
    manufactureroftradeitem character varying(255),
    gtin text
);


ALTER TABLE trade_items OWNER TO postgres;

--
-- Name: rights; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE rights (
    id uuid NOT NULL UNIQUE,
    name character varying(255),
    type character varying(255)
);


ALTER TABLE rights OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE users (
    id uuid NOT NULL UNIQUE,
    username character varying(255),
    firstname character varying(255),
    lastname character varying(255),
    homefacilityid uuid,
    active boolean,
    loginRestricted boolean
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE roles (
    id uuid NOT NULL,
    name character varying(255),
    description character varying(255),
    rightsname character varying(255),
    rightsid uuid,
    rightstype character varying(255),
    count INT
);


ALTER TABLE roles OWNER TO postgres;

--
-- Name: supervisorynodes; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE supervisorynodes (
    id uuid NOT NULL UNIQUE,
    name character varying(255),
    code character varying(255),
    facilityname character varying(255),
    facilityid uuid,
    requisitiongroupname character varying(255),
    requisitiongroupid uuid,
    parentnodename character varying(255),
    parentnodeid uuid
);


ALTER TABLE supervisorynodes OWNER TO postgres;

--
-- Name: requisitiongroups; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE requisitiongroups (
    id character varying(255) NOT NULL UNIQUE,
    name character varying(255),
    code character varying(255),
    facilityid uuid,
    supervisorynodeid uuid,
    supervisorynodename character varying(255),
    supervisorynodecode character varying(255),
    programname character varying(255),
    programid character varying(255),
    processingscheduleid character varying(255),
    directdelivery boolean
);


ALTER TABLE requisitiongroups OWNER TO postgres;

--
-- Name: supplylines; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE supplylines (
    id uuid NOT NULL UNIQUE,
    description character varying(255),
    supervisorynodeid uuid,
    programid uuid,
    supplyingfacilityid uuid
);


ALTER TABLE supplylines OWNER TO postgres;

--
-- Name: requisitions; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE requisitions (
  id uuid,
  created_date date,
  modified_date date,
  emergency_status boolean,
  supplying_facility varchar,
  supervisory_node varchar,
  facility_id varchar,
  facility_code varchar,
  facility_name varchar,
  facilty_active_status boolean,
  district_id varchar,
  district_code varchar,
  district_name varchar,
  region_id varchar,
  region_code varchar,
  region_name varchar,
  country_id varchar,
  country_code varchar,
  country_name varchar,
  facility_type_id varchar,
  facility_type_code varchar,
  facility_type_name varchar,
  facility_operator_id varchar,
  facility_operator_code varchar,
  facility_operator_name varchar,
  program_id varchar,
  program_code varchar,
  program_name varchar,
  program_active_status boolean,
  processing_period_id varchar,
  processing_period_name varchar,
  processing_period_startdate varchar,
  processing_period_enddate date,
  processing_schedule_id varchar,
  processing_schedule_code varchar,
  processing_schedule_name varchar 
);

ALTER TABLE requisitions OWNER TO postgres;

--
-- Name: requisition_line_item; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE requisition_line_item (
  requisition_line_item_id uuid,
  requisition_id varchar,
  orderable_id varchar,
  product_code varchar,
  full_product_name varchar,
  trade_item_id varchar,
  beginning_balance double precision,
  total_consumed_quantity double precision,
  average_consumption double precision,
  adjusted_consumption double precision,
  total_losses_and_adjustments double precision,
  stock_on_hand double precision,
  total_stockout_days double precision,
  max_periods_of_stock double precision,
  calculated_order_quantity double precision,
  requested_quantity double precision,
  approved_quantity double precision,
  packs_to_ship double precision,
  price_per_pack double precision,
  total_cost double precision,
  total_received_quantity double precision
);

ALTER TABLE requisition_line_item OWNER TO postgres;

--
-- Name: requisitions_status_history; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE requisitions_status_history (
  requisition_id varchar,
  status varchar,
  author_id varchar,
  created_date date
);

ALTER TABLE requisitions_status_history OWNER TO postgres;

--
-- Name: requisitions_adjustment_lines; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE requisitions_adjustment_lines (
  id varchar,
  reasonId varchar,
  quantity int,
  requisition_line_item_id varchar
);

ALTER TABLE requisitions_adjustment_lines OWNER TO postgres;

--
-- Name: sohlineitems; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE sohlineitems (
    stockCardID varchar,
    facilityID varchar,
    facilityCode varchar,
    facilityName varchar,
    facilityActive boolean,
    facilityEnabled boolean,
    facilityType varchar,
    programID varchar,
    programCode varchar,
    programName varchar,
    orderableID varchar,
    productCode varchar,
    fullProductName varchar,
    netContent int,
    lastUpdate varchar,
    quantity int,
    reasonName varchar,
    reasonType varchar,
    reasonCategory varchar,
    reasonID varchar,
    occurredDate varchar,
    stockOnHand int,
    sohlineitems_id varchar,
    source varchar,
    destination varchar
);

ALTER TABLE sohlineitems OWNER TO postgres;

--
-- Name: facility_access; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE facility_access (
    username varchar,
    facility varchar,
    program varchar
);

ALTER TABLE facility_access OWNER TO postgres;

--
-- Name: stock_adjustment_reasons; Type: TABLE; Schema: referencedata; Owner: postgres
--

CREATE TABLE stock_adjustment_reasons (
  id varchar,
  name varchar,
  additive boolean,
  displayorder int,
  description text,
  programid varchar,
  programname varchar
);

ALTER TABLE stock_adjustment_reasons OWNER TO postgres;