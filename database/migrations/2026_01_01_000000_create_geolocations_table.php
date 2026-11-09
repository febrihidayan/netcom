<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('geolocations', function (Blueprint $table) {
            $table->string('geolocation_zip_code_prefix')->primary();
            $table->decimal('geolocation_lat', 10, 8)->nullable();
            $table->decimal('geolocation_lng', 11, 8)->nullable();
            $table->string('geolocation_city')->nullable();
            $table->string('geolocation_state', 10)->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('geolocations');
    }
};