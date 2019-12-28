if [ "$#" -ne 1 ]; then
    echo "run using source export_api_key.sh <DD API key>"
else
    export DD_API_KEY="$1"
fi
