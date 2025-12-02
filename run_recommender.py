from pyswip import Prolog

# Load the Prolog module
prolog = Prolog()
prolog.consult("ecommerce.pl")

def get_recommendations(user):
    query = f"recommend({user}, Product)"
    results = list(prolog.query(query))

    # Extract products
    products = [res["Product"] for res in results]

    # Remove duplicates
    unique = []
    for p in products:
        if p not in unique:
            unique.append(p)
    return unique

if __name__ == "__main__":
    user = "john"
    recs = get_recommendations(user)
    print(f"Recommendations for {user}:")
    for r in recs:
        print(" -", r)
