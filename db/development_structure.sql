CREATE TABLE `country_orig` (
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dna_results` (
  `id` int(11) NOT NULL auto_increment,
  `sample_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `prep_number` int(11) default NULL,
  `extraction_number` int(11) default NULL,
  `barcode` varchar(255) default NULL,
  `plate` varchar(255) default NULL,
  `position` varchar(255) default NULL,
  `extraction_method` varchar(255) default NULL,
  `extraction_date` date default NULL,
  `extractor` varchar(255) default NULL,
  `extractor_comments` varchar(255) default NULL,
  `fluoro_conc` float default NULL,
  `functional_conc` float default NULL,
  `pico_green_conc` float default NULL,
  `storage_building` varchar(255) default NULL,
  `storage_room` varchar(255) default NULL,
  `storage_freezer` varchar(255) default NULL,
  `storage_box` varchar(255) default NULL,
  `xy_position` varchar(255) default NULL,
  `dna_remaining` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1185 DEFAULT CHARSET=latin1;

CREATE TABLE `dynamic_attribute_values` (
  `id` int(11) NOT NULL auto_increment,
  `dynamic_attribute_id` int(11) default NULL,
  `owner_type` varchar(255) default NULL,
  `owner_id` int(11) default NULL,
  `integer_value` int(11) default NULL,
  `float_value` decimal(10,0) default NULL,
  `text_value` text,
  `date_value` date default NULL,
  `timestamp_value` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_dynamic_attribute_values_on_dynamic_attribute_id` (`dynamic_attribute_id`),
  KEY `index_dynamic_attribute_values_on_owner_id` (`owner_id`),
  KEY `index_dynamic_attribute_values_on_owner_type` (`owner_type`),
  KEY `index_dynamic_attribute_values_on_owner_type_and_owner_id` (`owner_type`,`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=504 DEFAULT CHARSET=latin1;

CREATE TABLE `dynamic_attributes` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `dynamic_type_id` int(11) default NULL,
  `dynamic_class_id` int(11) default NULL,
  `scoper_type` varchar(255) default NULL,
  `scoper_id` int(11) default NULL,
  `owner_type` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_dynamic_attributes_on_name` (`name`),
  KEY `index_dynamic_attributes_on_dynamic_type_id` (`dynamic_type_id`),
  KEY `index_dynamic_attributes_on_dynamic_class_id` (`dynamic_class_id`),
  KEY `index_dynamic_attributes_on_owner_type` (`owner_type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `dynamic_classes` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_dynamic_classes_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `dynamic_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `stored_in_field` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_dynamic_types_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE `extraction_methods` (
  `id` int(11) NOT NULL auto_increment,
  `extraction_method_name` varchar(255) default NULL,
  `extraction_method_description` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE `gender_final_horizontals` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(255) default NULL,
  `gender` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `gender_final_horizontals_1` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(128) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=487 DEFAULT CHARSET=latin1;

CREATE TABLE `genders` (
  `id` int(11) NOT NULL auto_increment,
  `sample_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `gender` varchar(255) default NULL,
  `gelNum` varchar(255) default NULL,
  `wellNum` varchar(255) default NULL,
  `finalResult` tinyint(1) default NULL,
  `locus` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=637 DEFAULT CHARSET=latin1;

CREATE TABLE `locality_types` (
  `id` int(11) NOT NULL auto_increment,
  `locality_type_name` varchar(255) default NULL,
  `locality_type_desc` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

CREATE TABLE `mhc_final_horizontals` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(255) default NULL,
  `allelea` int(11) default NULL,
  `alleleb` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `mhc_final_horizontals_1` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(128) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=487 DEFAULT CHARSET=latin1;

CREATE TABLE `mhc_seqs` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `locus` varchar(255) default NULL,
  `allele` varchar(255) default NULL,
  `sequence` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `mhcs` (
  `id` int(11) NOT NULL auto_increment,
  `sample_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `locus` varchar(255) default NULL,
  `allele1` varchar(255) default NULL,
  `allele2` varchar(255) default NULL,
  `gelNum` varchar(255) default NULL,
  `wellNum` varchar(255) default NULL,
  `finalResult` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `microsatellite_final_horizontals` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(255) default NULL,
  `allelea` int(11) default NULL,
  `alleleb` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `microsatellite_final_horizontals_1` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(128) default NULL,
  `EV1Pma` int(11) default NULL,
  `EV1Pmb` int(11) default NULL,
  `EV37Mna` int(11) default NULL,
  `EV37Mnb` int(11) default NULL,
  `GATA028a` int(11) default NULL,
  `GATA028b` int(11) default NULL,
  `GT023a` int(11) default NULL,
  `GT023b` int(11) default NULL,
  `GT271a` int(11) default NULL,
  `GT271b` int(11) default NULL,
  `IGFa` int(11) default NULL,
  `IGFb` int(11) default NULL,
  `RW18a` int(11) default NULL,
  `RW18b` int(11) default NULL,
  `RW212a` int(11) default NULL,
  `RW212b` int(11) default NULL,
  `RW217a` int(11) default NULL,
  `RW217b` int(11) default NULL,
  `RW219a` int(11) default NULL,
  `RW219b` int(11) default NULL,
  `RW25a` int(11) default NULL,
  `RW25b` int(11) default NULL,
  `RW31a` int(11) default NULL,
  `RW31b` int(11) default NULL,
  `RW34a` int(11) default NULL,
  `RW34b` int(11) default NULL,
  `RW417a` int(11) default NULL,
  `RW417b` int(11) default NULL,
  `RW45a` int(11) default NULL,
  `RW45b` int(11) default NULL,
  `RW48a` int(11) default NULL,
  `RW48b` int(11) default NULL,
  `SAM25a` int(11) default NULL,
  `SAM25b` int(11) default NULL,
  `TR2F3a` int(11) default NULL,
  `TR2F3b` int(11) default NULL,
  `TR2G5a` int(11) default NULL,
  `TR2G5b` int(11) default NULL,
  `TR3A1a` int(11) default NULL,
  `TR3A1b` int(11) default NULL,
  `TR3F2a` int(11) default NULL,
  `TR3F2b` int(11) default NULL,
  `TR3F7a` int(11) default NULL,
  `TR3F7b` int(11) default NULL,
  `TR3G1a` int(11) default NULL,
  `TR3G1b` int(11) default NULL,
  `TR3G10a` int(11) default NULL,
  `TR3G10b` int(11) default NULL,
  `TR3G11a` int(11) default NULL,
  `TR3G11b` int(11) default NULL,
  `TR3G13a` int(11) default NULL,
  `TR3G13b` int(11) default NULL,
  `TR3G2a` int(11) default NULL,
  `TR3G2b` int(11) default NULL,
  `TR3G5a` int(11) default NULL,
  `TR3G5b` int(11) default NULL,
  `TR3G6a` int(11) default NULL,
  `TR3G6b` int(11) default NULL,
  `TR3H14a` int(11) default NULL,
  `TR3H14b` int(11) default NULL,
  `TR3H4a` int(11) default NULL,
  `TR3H4b` int(11) default NULL,
  `TV14a` int(11) default NULL,
  `TV14b` int(11) default NULL,
  `TV17a` int(11) default NULL,
  `TV17b` int(11) default NULL,
  `TV19a` int(11) default NULL,
  `TV19b` int(11) default NULL,
  `TV20a` int(11) default NULL,
  `TV20b` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=487 DEFAULT CHARSET=latin1;

CREATE TABLE `microsatellite_final_horizontals_2` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(128) default NULL,
  `extraction_number` int(11) default NULL,
  `EV1Pma` int(11) default NULL,
  `EV1Pmb` int(11) default NULL,
  `EV37Mna` int(11) default NULL,
  `EV37Mnb` int(11) default NULL,
  `GATA028a` int(11) default NULL,
  `GATA028b` int(11) default NULL,
  `GT023a` int(11) default NULL,
  `GT023b` int(11) default NULL,
  `GT271a` int(11) default NULL,
  `GT271b` int(11) default NULL,
  `IGFa` int(11) default NULL,
  `IGFb` int(11) default NULL,
  `RW18a` int(11) default NULL,
  `RW18b` int(11) default NULL,
  `RW212a` int(11) default NULL,
  `RW212b` int(11) default NULL,
  `RW217a` int(11) default NULL,
  `RW217b` int(11) default NULL,
  `RW219a` int(11) default NULL,
  `RW219b` int(11) default NULL,
  `RW25a` int(11) default NULL,
  `RW25b` int(11) default NULL,
  `RW31a` int(11) default NULL,
  `RW31b` int(11) default NULL,
  `RW34a` int(11) default NULL,
  `RW34b` int(11) default NULL,
  `RW417a` int(11) default NULL,
  `RW417b` int(11) default NULL,
  `RW45a` int(11) default NULL,
  `RW45b` int(11) default NULL,
  `RW48a` int(11) default NULL,
  `RW48b` int(11) default NULL,
  `SAM25a` int(11) default NULL,
  `SAM25b` int(11) default NULL,
  `TR2F3a` int(11) default NULL,
  `TR2F3b` int(11) default NULL,
  `TR2G5a` int(11) default NULL,
  `TR2G5b` int(11) default NULL,
  `TR3A1a` int(11) default NULL,
  `TR3A1b` int(11) default NULL,
  `TR3F2a` int(11) default NULL,
  `TR3F2b` int(11) default NULL,
  `TR3F7a` int(11) default NULL,
  `TR3F7b` int(11) default NULL,
  `TR3G1a` int(11) default NULL,
  `TR3G1b` int(11) default NULL,
  `TR3G10a` int(11) default NULL,
  `TR3G10b` int(11) default NULL,
  `TR3G11a` int(11) default NULL,
  `TR3G11b` int(11) default NULL,
  `TR3G13a` int(11) default NULL,
  `TR3G13b` int(11) default NULL,
  `TR3G2a` int(11) default NULL,
  `TR3G2b` int(11) default NULL,
  `TR3G5a` int(11) default NULL,
  `TR3G5b` int(11) default NULL,
  `TR3G6a` int(11) default NULL,
  `TR3G6b` int(11) default NULL,
  `TR3H14a` int(11) default NULL,
  `TR3H14b` int(11) default NULL,
  `TR3H4a` int(11) default NULL,
  `TR3H4b` int(11) default NULL,
  `TV14a` int(11) default NULL,
  `TV14b` int(11) default NULL,
  `TV17a` int(11) default NULL,
  `TV17b` int(11) default NULL,
  `TV19a` int(11) default NULL,
  `TV19b` int(11) default NULL,
  `TV20a` int(11) default NULL,
  `TV20b` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `microsatellite_horizontals` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `sample_id` int(11) default NULL,
  `organism_code` varchar(255) default NULL,
  `org_sample` int(11) default NULL,
  `allelea` int(11) default NULL,
  `alleleb` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `microsatellite_horizontals_1` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `sample_id` int(11) default NULL,
  `organism_code` int(11) default NULL,
  `org_sample` int(11) default NULL,
  `EV1Pma` int(11) default NULL,
  `EV1Pmb` int(11) default NULL,
  `EV37Mna` int(11) default NULL,
  `EV37Mnb` int(11) default NULL,
  `GATA028a` int(11) default NULL,
  `GATA028b` int(11) default NULL,
  `GT023a` int(11) default NULL,
  `GT023b` int(11) default NULL,
  `GT271a` int(11) default NULL,
  `GT271b` int(11) default NULL,
  `IGFa` int(11) default NULL,
  `IGFb` int(11) default NULL,
  `RW18a` int(11) default NULL,
  `RW18b` int(11) default NULL,
  `RW212a` int(11) default NULL,
  `RW212b` int(11) default NULL,
  `RW217a` int(11) default NULL,
  `RW217b` int(11) default NULL,
  `RW219a` int(11) default NULL,
  `RW219b` int(11) default NULL,
  `RW25a` int(11) default NULL,
  `RW25b` int(11) default NULL,
  `RW31a` int(11) default NULL,
  `RW31b` int(11) default NULL,
  `RW34a` int(11) default NULL,
  `RW34b` int(11) default NULL,
  `RW417a` int(11) default NULL,
  `RW417b` int(11) default NULL,
  `RW45a` int(11) default NULL,
  `RW45b` int(11) default NULL,
  `RW48a` int(11) default NULL,
  `RW48b` int(11) default NULL,
  `SAM25a` int(11) default NULL,
  `SAM25b` int(11) default NULL,
  `TR2F3a` int(11) default NULL,
  `TR2F3b` int(11) default NULL,
  `TR2G5a` int(11) default NULL,
  `TR2G5b` int(11) default NULL,
  `TR3A1a` int(11) default NULL,
  `TR3A1b` int(11) default NULL,
  `TR3F2a` int(11) default NULL,
  `TR3F2b` int(11) default NULL,
  `TR3F7a` int(11) default NULL,
  `TR3F7b` int(11) default NULL,
  `TR3G1a` int(11) default NULL,
  `TR3G1b` int(11) default NULL,
  `TR3G10a` int(11) default NULL,
  `TR3G10b` int(11) default NULL,
  `TR3G11a` int(11) default NULL,
  `TR3G11b` int(11) default NULL,
  `TR3G13a` int(11) default NULL,
  `TR3G13b` int(11) default NULL,
  `TR3G2a` int(11) default NULL,
  `TR3G2b` int(11) default NULL,
  `TR3G5a` int(11) default NULL,
  `TR3G5b` int(11) default NULL,
  `TR3G6a` int(11) default NULL,
  `TR3G6b` int(11) default NULL,
  `TR3H14a` int(11) default NULL,
  `TR3H14b` int(11) default NULL,
  `TR3H4a` int(11) default NULL,
  `TR3H4b` int(11) default NULL,
  `TV14a` int(11) default NULL,
  `TV14b` int(11) default NULL,
  `TV17a` int(11) default NULL,
  `TV17b` int(11) default NULL,
  `TV19a` int(11) default NULL,
  `TV19b` int(11) default NULL,
  `TV20a` int(11) default NULL,
  `TV20b` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=847 DEFAULT CHARSET=latin1;

CREATE TABLE `microsatellite_horizontals_2` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `sample_id` int(11) default NULL,
  `organism_code` int(11) default NULL,
  `org_sample` int(11) default NULL,
  `extraction_number` int(11) default NULL,
  `EV1Pma` int(11) default NULL,
  `EV1Pmb` int(11) default NULL,
  `EV37Mna` int(11) default NULL,
  `EV37Mnb` int(11) default NULL,
  `GATA028a` int(11) default NULL,
  `GATA028b` int(11) default NULL,
  `GT023a` int(11) default NULL,
  `GT023b` int(11) default NULL,
  `GT271a` int(11) default NULL,
  `GT271b` int(11) default NULL,
  `IGFa` int(11) default NULL,
  `IGFb` int(11) default NULL,
  `RW18a` int(11) default NULL,
  `RW18b` int(11) default NULL,
  `RW212a` int(11) default NULL,
  `RW212b` int(11) default NULL,
  `RW217a` int(11) default NULL,
  `RW217b` int(11) default NULL,
  `RW219a` int(11) default NULL,
  `RW219b` int(11) default NULL,
  `RW25a` int(11) default NULL,
  `RW25b` int(11) default NULL,
  `RW31a` int(11) default NULL,
  `RW31b` int(11) default NULL,
  `RW34a` int(11) default NULL,
  `RW34b` int(11) default NULL,
  `RW417a` int(11) default NULL,
  `RW417b` int(11) default NULL,
  `RW45a` int(11) default NULL,
  `RW45b` int(11) default NULL,
  `RW48a` int(11) default NULL,
  `RW48b` int(11) default NULL,
  `SAM25a` int(11) default NULL,
  `SAM25b` int(11) default NULL,
  `TR2F3a` int(11) default NULL,
  `TR2F3b` int(11) default NULL,
  `TR2G5a` int(11) default NULL,
  `TR2G5b` int(11) default NULL,
  `TR3A1a` int(11) default NULL,
  `TR3A1b` int(11) default NULL,
  `TR3F2a` int(11) default NULL,
  `TR3F2b` int(11) default NULL,
  `TR3F7a` int(11) default NULL,
  `TR3F7b` int(11) default NULL,
  `TR3G1a` int(11) default NULL,
  `TR3G1b` int(11) default NULL,
  `TR3G10a` int(11) default NULL,
  `TR3G10b` int(11) default NULL,
  `TR3G11a` int(11) default NULL,
  `TR3G11b` int(11) default NULL,
  `TR3G13a` int(11) default NULL,
  `TR3G13b` int(11) default NULL,
  `TR3G2a` int(11) default NULL,
  `TR3G2b` int(11) default NULL,
  `TR3G5a` int(11) default NULL,
  `TR3G5b` int(11) default NULL,
  `TR3G6a` int(11) default NULL,
  `TR3G6b` int(11) default NULL,
  `TR3H14a` int(11) default NULL,
  `TR3H14b` int(11) default NULL,
  `TR3H4a` int(11) default NULL,
  `TR3H4b` int(11) default NULL,
  `TV14a` int(11) default NULL,
  `TV14b` int(11) default NULL,
  `TV17a` int(11) default NULL,
  `TV17b` int(11) default NULL,
  `TV19a` int(11) default NULL,
  `TV19b` int(11) default NULL,
  `TV20a` int(11) default NULL,
  `TV20b` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `microsatellites` (
  `id` int(11) NOT NULL auto_increment,
  `sample_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `locus` varchar(255) default NULL,
  `allele1` varchar(255) default NULL,
  `allele2` varchar(255) default NULL,
  `gel` varchar(255) default NULL,
  `well` varchar(255) default NULL,
  `finalResult` tinyint(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `Index_2` (`sample_id`,`project_id`,`locus`),
  KEY `index_microsatellites_on_locus` (`locus`),
  KEY `index_microsatellites_on_allele1` (`allele1`),
  KEY `index_microsatellites_on_allele2` (`allele2`),
  KEY `index_microsatellites_on_finalResult` (`finalResult`)
) ENGINE=InnoDB AUTO_INCREMENT=20931 DEFAULT CHARSET=latin1;

CREATE TABLE `microsatellites_project_001_by_sample` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` varchar(50) default NULL,
  `organism_code` double default NULL,
  `org_Sample` double default NULL,
  `extraction_number` double default NULL,
  `EV1Pma` double default NULL,
  `EVPm1b` double default NULL,
  `EV37Mna` double default NULL,
  `EV37Mnb` double default NULL,
  `GATA028a` double default NULL,
  `GATA028b` double default NULL,
  `GT023a` double default NULL,
  `GT023b` double default NULL,
  `GT271a` double default NULL,
  `GT271b` double default NULL,
  `IGFa` double default NULL,
  `IGFb` double default NULL,
  `RW18a` double default NULL,
  `RW18b` double default NULL,
  `RW25a` double default NULL,
  `RW25b` double default NULL,
  `RW31a` double default NULL,
  `RW31b` double default NULL,
  `RW34a` double default NULL,
  `RW34b` double default NULL,
  `RW45a` double default NULL,
  `RW45b` double default NULL,
  `RW48a` double default NULL,
  `RW48b` double default NULL,
  `RW212a` double default NULL,
  `RW212b` double default NULL,
  `RW217a` double default NULL,
  `RW217b` double default NULL,
  `RW219a` double default NULL,
  `RW219b` double default NULL,
  `RW417a` double default NULL,
  `RW417b` double default NULL,
  `SAM25a` double default NULL,
  `SAM25b` double default NULL,
  `TR2F3a` double default NULL,
  `TR2F3b` double default NULL,
  `TR2G5a` double default NULL,
  `TR2G5b` double default NULL,
  `TR3A1a` double default NULL,
  `TR3A1b` double default NULL,
  `TR3F2a` double default NULL,
  `TR3F2b` double default NULL,
  `TR3F7a` double default NULL,
  `TR3F7b` double default NULL,
  `TR3G1a` double default NULL,
  `TR3G1b` double default NULL,
  `TR3G2a` double default NULL,
  `TR3G2b` double default NULL,
  `TR3G5a` double default NULL,
  `TR3G5b` double default NULL,
  `TR3G6a` double default NULL,
  `TR3G6b` double default NULL,
  `TR3G10a` double default NULL,
  `TR3G10b` double default NULL,
  `TR3G11a` double default NULL,
  `TR3G11b` double default NULL,
  `TR3G13a` double default NULL,
  `TR3G13b` double default NULL,
  `TR3H4a` double default NULL,
  `TR3H4b` double default NULL,
  `TR3H14a` double default NULL,
  `TR3H14b` double default NULL,
  `TV14a` double default NULL,
  `TV14b` double default NULL,
  `TV17a` double default NULL,
  `TV17b` double default NULL,
  `TV19a` double default NULL,
  `TV19b` double default NULL,
  `TV20a` double default NULL,
  `TV20b` double default NULL,
  `sample_id` int(11) default NULL,
  PRIMARY KEY  USING BTREE (`id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=599 DEFAULT CHARSET=latin1;

CREATE TABLE `mt_dna_final_horizontals` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(255) default NULL,
  `haplotype` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `mt_dna_final_horizontals_1` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(128) default NULL,
  `Control Region` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=487 DEFAULT CHARSET=latin1;

CREATE TABLE `mt_dna_seqs` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `locus` varchar(255) default NULL,
  `haplotype` varchar(255) default NULL,
  `sequence` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE `mt_dnas` (
  `id` int(11) NOT NULL auto_increment,
  `sample_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `locus` varchar(255) default NULL,
  `haplotype` varchar(255) default NULL,
  `gelNum` varchar(255) default NULL,
  `wellNum` varchar(255) default NULL,
  `finalResult` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=602 DEFAULT CHARSET=latin1;

CREATE TABLE `organisms` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_code` varchar(255) default NULL,
  `comment` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=487 DEFAULT CHARSET=latin1;

CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `code` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `user_id` int(11) default NULL,
  `recompile_required` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `province_state_orig` (
  `PROVINCE_STATE_PK` varchar(2) NOT NULL,
  `PROVINCE_STATE_DESC` varchar(30) default NULL,
  `COUNTRY_FK` int(11) default NULL,
  PRIMARY KEY  (`PROVINCE_STATE_PK`),
  KEY `COUNTRY_CODE` (`COUNTRY_FK`),
  KEY `CountryProvince_State` (`COUNTRY_FK`),
  CONSTRAINT `province_state_orig_ibfk_1` FOREIGN KEY (`COUNTRY_FK`) REFERENCES `country_orig` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `sample_non_tissues` (
  `id` int(11) NOT NULL auto_increment,
  `organism_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `field_code` varchar(255) default NULL,
  `prov` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  `date_collected` date default NULL,
  `collected_by` varchar(255) default NULL,
  `submitted_by` varchar(255) default NULL,
  `date_submitted` date default NULL,
  `submitter_comments` text,
  `received_by` varchar(255) default NULL,
  `date_received` date default NULL,
  `receiver_comments` text,
  `latitude` float default NULL,
  `longitude` float default NULL,
  `UTM_datum` float default NULL,
  `locality` varchar(255) default NULL,
  `locality_type` varchar(255) default NULL,
  `locality_comments` varchar(255) default NULL,
  `location_accuracy` varchar(255) default NULL,
  `type_lat_long` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `samples` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(255) default NULL,
  `org_sample` varchar(255) default NULL,
  `tubebc` varchar(255) default NULL,
  `platebc` varchar(255) default NULL,
  `plateposition` varchar(255) default NULL,
  `field_code` varchar(255) default NULL,
  `batch_number` varchar(255) default NULL,
  `tissue_type` varchar(255) default NULL,
  `storage_medium` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  `province` varchar(255) default NULL,
  `date_collected` datetime default NULL,
  `collected_on_day` int(11) default NULL,
  `collected_on_month` int(11) default NULL,
  `collected_on_year` int(11) default NULL,
  `collected_by` varchar(255) default NULL,
  `date_received` datetime default NULL,
  `received_by` varchar(255) default NULL,
  `receiver_comments` text,
  `date_submitted` datetime default NULL,
  `submitted_by` varchar(255) default NULL,
  `submitter_comments` text,
  `latitude` float default NULL,
  `longitude` float default NULL,
  `UTM_datum` float default NULL,
  `locality` varchar(255) default NULL,
  `locality_type` varchar(255) default NULL,
  `locality_comments` varchar(255) default NULL,
  `location_accuracy` varchar(255) default NULL,
  `storage_building` varchar(255) default NULL,
  `storage_room` varchar(255) default NULL,
  `storage_fridge` varchar(255) default NULL,
  `storage_box` varchar(255) default NULL,
  `xy_position` varchar(255) default NULL,
  `tissue_remaining` tinyint(1) default NULL,
  `type_lat_long` varchar(255) default NULL,
  `locality_type_id` int(11) default NULL,
  `shippingmaterial_id` int(11) default NULL,
  `tissue_type_id` int(11) default NULL,
  `province_id` int(11) default NULL,
  `storage_medium_id` int(11) default NULL,
  `country_id` int(11) default NULL,
  `extraction_method_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_samples_on_organism_id` (`organism_id`),
  KEY `index_samples_on_organism_code` (`organism_code`),
  KEY `index_samples_on_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=847 DEFAULT CHARSET=latin1;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `security_settings` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `level` int(11) default '0',
  PRIMARY KEY  (`id`),
  KEY `index_security_settings_on_project_id` (`project_id`),
  KEY `index_security_settings_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE `shippingmaterials` (
  `id` int(11) NOT NULL auto_increment,
  `medium_short_desc` varchar(255) default NULL,
  `medium_long_desc` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

CREATE TABLE `tissue_types` (
  `id` int(11) NOT NULL auto_increment,
  `tissue_type` varchar(255) default NULL,
  `comment` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `login` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(255) default NULL,
  `remember_token_expires_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `y_chromosome_final_horizontals` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(255) default NULL,
  `haplotype` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `y_chromosome_final_horizontals_1` (
  `id` int(11) NOT NULL auto_increment,
  `project_id` int(11) default NULL,
  `organism_id` int(11) default NULL,
  `organism_code` varchar(128) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=487 DEFAULT CHARSET=latin1;

CREATE TABLE `y_chromosome_seqs` (
  `id` int(11) NOT NULL auto_increment,
  `sample_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `locus` varchar(255) default NULL,
  `haplotype` varchar(255) default NULL,
  `sequence` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `y_chromosomes` (
  `id` int(11) NOT NULL auto_increment,
  `sample_id` int(11) default NULL,
  `project_id` int(11) default NULL,
  `locus` varchar(255) default NULL,
  `haplotype` varchar(255) default NULL,
  `gelNum` varchar(255) default NULL,
  `wellNum` varchar(255) default NULL,
  `finalResult` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `schema_info` (version) VALUES (37)