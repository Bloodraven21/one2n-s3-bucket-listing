from django.test import TestCase
from django.urls import reverse

class S3BucketTests(TestCase):
    
    def test_list_top_level_content(self):
        """
        Test listing the top-level content of the S3 bucket.
        """
        response = self.client.get(reverse('list_bucket_content'))  # This will call /list-bucket-content/
        self.assertEqual(response.status_code, 200)
        self.assertIn('content', response.json())

    def test_list_directory_content(self):
        """
        Test listing content inside a specific directory.
        """
        response = self.client.get(reverse('list_bucket_content', args=['dir1/']))  # This will call /list-bucket-content/dir1/
        self.assertEqual(response.status_code, 200)
        self.assertIn('content', response.json())

    def test_non_existing_path(self):
        """
        Test handling of a non-existing path.
        """
        response = self.client.get(reverse('list_bucket_content', args=['non-existing/']))  # This will call /list-bucket-content/non-existing/
        self.assertEqual(response.status_code, 400)
        self.assertIn('error', response.json())
