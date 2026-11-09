<?php

namespace App\Http\Controllers;

use App\Models\Geolocation;
use Illuminate\Http\Request;
use Inertia\Inertia;

class GeolocationController extends Controller
{
    protected array $tableFields = ['geolocation_zip_code_prefix','geolocation_city','geolocation_state','geolocation_lat','geolocation_lng'];
    protected array $formFields = ['geolocation_zip_code_prefix','geolocation_lat','geolocation_lng','geolocation_city','geolocation_state'];
    protected array $labels = [
        'geolocation_zip_code_prefix' => 'Zip Code Prefix',
        'geolocation_lat' => 'Latitude',
        'geolocation_lng' => 'Longitude',
        'geolocation_city' => 'City',
        'geolocation_state' => 'State',
    ];

    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 15);
        $search = $request->input('search');

        $query = Geolocation::query();
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('geolocation_zip_code_prefix', 'like', "%{$search}%")
                    ->orWhere('geolocation_city', 'like', "%{$search}%")
                    ->orWhere('geolocation_state', 'like', "%{$search}%");
            });
        }

        return Inertia::render('Crud/Index', [
            'title' => 'Geolocations',
            'resource' => 'geolocations',
            'fields' => $this->tableFields,
            'keyField' => 'geolocation_zip_code_prefix',
            'labels' => $this->labels,
            'items' => $query->paginate($perPage)->withQueryString(),
            'filters' => ['search' => $search, 'per_page' => $perPage],
        ]);
    }

    public function create()
    {
        return Inertia::render('Crud/Create', [
            'title' => 'Geolocation',
            'resource' => 'geolocations',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'geolocation_zip_code_prefix' => 'required|string|max:20',
            'geolocation_lat' => 'nullable|numeric',
            'geolocation_lng' => 'nullable|numeric',
            'geolocation_city' => 'nullable|string|max:255',
            'geolocation_state' => 'nullable|string|max:10',
        ]);

        Geolocation::create($validated);

        return redirect()->route('geolocations.index');
    }

    public function show(Geolocation $geolocation)
    {
        return Inertia::render('Crud/Show', [
            'title' => 'Geolocation',
            'resource' => 'geolocations',
            'fields' => $this->tableFields,
            'labels' => $this->labels,
            'item' => $geolocation,
        ]);
    }

    public function edit(Geolocation $geolocation)
    {
        return Inertia::render('Crud/Edit', [
            'title' => 'Geolocation',
            'resource' => 'geolocations',
            'fields' => $this->tableFields,
            'formFields' => $this->formFields,
            'labels' => $this->labels,
            'item' => $geolocation,
        ]);
    }

    public function update(Request $request, Geolocation $geolocation)
    {
        $validated = $request->validate([
            'geolocation_lat' => 'nullable|numeric',
            'geolocation_lng' => 'nullable|numeric',
            'geolocation_city' => 'nullable|string|max:255',
            'geolocation_state' => 'nullable|string|max:10',
        ]);

        $geolocation->update($validated);

        return redirect()->route('geolocations.index');
    }

    public function destroy(Geolocation $geolocation)
    {
        $geolocation->delete();

        return redirect()->route('geolocations.index');
    }
}