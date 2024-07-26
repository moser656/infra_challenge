import re

def is_valid_card_number(card_number):
    # Check if the card number has groups of 4 digits separated by hyphens
    if re.match(r'^(\d{4}-){3}\d{4}$', card_number):
        # Remove hyphens for further validation
        card_number = card_number.replace('-', '')
    elif re.match(r'^\d{16}$', card_number):
        # No hyphens, just 16 digits
        pass
    else:
        return False

    # Remove spaces (not necessary for this format but safe-keeping)
    card_number = card_number.replace(' ', '')
    
    # Check if it starts with 4, 5, or 6
    if not re.match(r'^[456]', card_number):
        return False
    
    # Check if it contains exactly 16 digits
    if len(card_number) != 16 or not card_number.isdigit():
        return False
    
    # Check if it has 4 or more consecutive repeated digits
    if re.search(r'(\d)\1{3,}', card_number):
        return False
    
    return True

def main():
    import sys
    input = sys.stdin.read
    data = input().strip().split('\n')

    try:
        number_of_samples = int(data[0].strip())
        if not (1 <= number_of_samples <= 10):
            raise ValueError("The number of samples must be between 1 and 10.")
    except ValueError as e:
        print(e)
        return
    
    # Process each card number
    for i in range(1, number_of_samples + 1):
        card_number = data[i].strip()
        if is_valid_card_number(card_number):
            print("Valid")
        else:
            print("Invalid")

if __name__ == "__main__":
    main()
