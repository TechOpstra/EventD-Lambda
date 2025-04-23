import json
import boto3
from PIL import Image
from io import BytesIO

def resize_image(image_data, max_size=(800, 800)):
    """
    Resizes the given image to the specified max size while maintaining aspect ratio.

    :param image_data: Byte data of the image to resize
    :param max_size: Tuple (width, height) specifying the max size for the resized image
    :return: Byte data of the resized image
    """
    # Open the image from the byte data
    with Image.open(BytesIO(image_data)) as img:
        # Check if the image is in 'RGB' mode; convert if not
        if img.mode != 'RGB':
            img = img.convert('RGB')

        # Resize the image, maintaining aspect ratio
        img.thumbnail(max_size)

        # Save the resized image to a byte buffer
        byte_io = BytesIO()
        img.save(byte_io, format='JPEG')
        byte_io.seek(0)
        return byte_io.read()


def lambda_handler(event, context):
    # Initialize S3 client
    s3_client = boto3.client('s3')

    # Extract the bucket name and file name from the event object (S3 trigger)
    s3_bucket_name = event['Records'][0]['s3']['bucket']['name']
    s3_key = event['Records'][0]['s3']['object']['key']

    # Get the image from S3
    try:
        response = s3_client.get_object(Bucket=s3_bucket_name, Key=s3_key)
        image_data = response['Body'].read()
    except Exception as e:
        print(f"Error retrieving object from S3: {e}")
        raise e

    # Resize the image
    resized_image_data = resize_image(image_data)

    # Upload the resized image back to S3 in a different bucket (processed images bucket)
    processed_bucket = 'processed-image-bucket'  # Replace with your bucket name
    processed_key = f"resized-{s3_key}"

    try:
        s3_client.put_object(Body=resized_image_data, Bucket=processed_bucket, Key=processed_key)
        print(f"Image processed and uploaded to {processed_bucket}/{processed_key}")
    except Exception as e:
        print(f"Error uploading processed image to S3: {e}")
        raise e

    return {
        'statusCode': 200,
        'body': json.dumps(f"Image processed and uploaded to {processed_bucket}/{processed_key}")
    }

