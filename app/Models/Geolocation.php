<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Geolocation extends Model
{
    use HasFactory;
    protected $table = 'geolocations';
    protected $primaryKey = 'geolocation_zip_code_prefix';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'geolocation_zip_code_prefix',
        'geolocation_lat',
        'geolocation_lng',
        'geolocation_city',
        'geolocation_state',
    ];

    protected $casts = [
        'geolocation_lat' => 'decimal:8',
        'geolocation_lng' => 'decimal:8',
    ];
}