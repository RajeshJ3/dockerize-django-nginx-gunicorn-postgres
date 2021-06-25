from django.http import JsonResponse

def home(request):

    data = {
        "message": "Welcome!",
    }

    print(f"------\n\n{data=}\n\n------")

    return JsonResponse(data)