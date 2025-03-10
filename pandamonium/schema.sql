/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `nsi_eleve1`
--

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS bamboos;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS branches;
DROP TABLE IF EXISTS messages;
CREATE TABLE users(uuid VARCHAR(36), username VARCHAR(50) NOT NULL, email VARCHAR(50), password VARCHAR(512), date_of_birth DATE, friends VARCHAR(3600), relations VARCHAR(3600), bamboos VARCHAR(3600), registration_date DATE, last_connection_date DATETIME, pronouns VARCHAR(50), public_display_name VARCHAR(50), public_bio VARCHAR(300), private_display_name VARCHAR(50), private_bio VARCHAR(300), PRIMARY KEY(uuid), UNIQUE(username), UNIQUE(email));
CREATE TABLE bamboos(uuid VARCHAR(36), name VARCHAR(50) NOT NULL, creation_date DATE, members TEXT, owner_uuid VARCHAR(36) NOT NULL, PRIMARY KEY(uuid), FOREIGN KEY(owner_uuid) REFERENCES users(uuid));
/*CREATE TABLE category(uuid VARCHAR(36), name VARCHAR(20), bamboo_uuid VARCHAR(36) NOT NULL, PRIMARY KEY(uuid), FOREIGN KEY(bamboo_uuid) REFERENCES bamboos(uuid));*/
CREATE TABLE branches(uuid VARCHAR(36), name VARCHAR(30) NOT NULL, bamboo_uuid VARCHAR(36) NOT NULL, PRIMARY KEY(uuid), FOREIGN KEY(bamboo_uuid) REFERENCES bamboos(uuid));
CREATE TABLE messages(uuid VARCHAR(36), content VARCHAR(2000) NOT NULL, date_sent DATETIME, modified BOOLEAN NOT NULL, sender_uuid VARCHAR(36) NOT NULL, branch_uuid VARCHAR(36) NOT NULL, response_to_message_uuid VARCHAR(36), PRIMARY KEY(uuid), FOREIGN KEY(sender_uuid) REFERENCES users(uuid), FOREIGN KEY(branch_uuid) REFERENCES branches(uuid), FOREIGN KEY(response_to_message_uuid) REFERENCES messages(uuid));

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;