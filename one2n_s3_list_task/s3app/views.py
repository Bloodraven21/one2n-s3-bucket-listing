import boto3
from django.http import JsonResponse
from django.conf import settings
from botocore.exceptions import ClientError

def list_bucket_content(request, path=None):
    """
    Handle GET request and return the contents of an S3 bucket path.
    If no path is specified, return the top-level content.
    """
    # Initialize S3 client
    s3 = boto3.client(
        's3',
        aws_access_key_id=settings.AWS_ACCESS_KEY_ID,
        aws_secret_access_key=settings.AWS_SECRET_ACCESS_KEY,
        region_name=settings.AWS_REGION
    )

    bucket_name = settings.AWS_S3_BUCKET_NAME
    prefix = path if path else ''  # Set prefix to the path, or empty for top-level

    # Ensure the prefix has a trailing slash for directories
    if prefix and not prefix.endswith('/'):
        prefix += '/'

    try:
        # List objects in the specified S3 path (prefix)
        response = s3.list_objects_v2(Bucket=bucket_name, Prefix=prefix, Delimiter='/')

        # Handle case where path does not exist or is empty
        if 'Contents' not in response and 'CommonPrefixes' not in response:
            return JsonResponse({"error": f"Path '{prefix}' not found or is empty"}, status=404)

        # Collect directories (sub-folders) and files
        directories = [prefix_obj['Prefix'].rstrip('/') for prefix_obj in response.get('CommonPrefixes', [])]
        files = [file_obj['Key'].replace(prefix, '').lstrip('/') for file_obj in response.get('Contents', []) if file_obj['Key'] != prefix]

        # Return the JSON response
        return JsonResponse({"content": directories + files})

    except ClientError as e:
        return JsonResponse({"error": str(e)}, status=500)
