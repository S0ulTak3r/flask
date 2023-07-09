import unittest
import sys
sys.path.append("..")
from app import app

class TestApp(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_home_status_code(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)

    def test_home_data(self):
        response = self.app.get('/')
        self.assertIn(b'The American Psycho Dream', response.data)
        self.assertIn(b'Courtesy: <a href="http://www.buzzfeed.com/copyranter/the-best-cat-gif-post-in-the-history-of-cat-gifs">Buzzfeed</a>', response.data)

if __name__ == '__main__':
    unittest.main()
