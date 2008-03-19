#! /bin/bash
mysqladmin drop nrdpfc_development -u root
mysqladmin create nrdpfc_development -u root
mysql -u root nrdpfc_development < /rails_apps/nrdpfc/db/nrdpfc_development.sql
