-- Createeaee `images` table
CREATE TABLE images(
   id INT AUTO_INCREMENT PRIMARY KEY,
   url VARCHAR(500) NOT NULL,
   description VARCHAR(500) NOT NULL 
);

-- Insert the cat images with URLs and descriptions
INSERT INTO images(url, description) VALUES
('https://media.tenor.com/Wi9uNKlPjZ0AAAAM/american-psycho-smoke.gif', 'a'),
('https://media.tenor.com/TDSHLyUWghwAAAAd/american-psycho-tense.gif', 'a'),
('https://i.pinimg.com/originals/c5/52/8e/c5528e6c4bb0a0ed0b7a3fcf127c68a2.gif', 'a'),
('https://media.tenor.com/GxA2qm-qmlkAAAAM/meme-american-psycho.gif', 'a'),
('https://media.tenor.com/xV70qxxgM14AAAAM/patrick-bateman.gif', 'a');