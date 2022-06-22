# Cartography

Funciones de Matlab para tratar con la conversión entre diferentes sistemas de coordenadas.

## Descripción

| Función | Descripción |
| ------- | ----------- |
| `ellipsoid()` | Obtener parámetros de elipsoides a partir de su código [EPSG](https://epsg.org/home.html). |
| `geo2tm()` | Conversión de [coordenadas geodésicas](https://en.wikipedia.org/wiki/Geodetic_coordinates) (&varphi;, &lambda;) a coordenadas proyectadas usando el sistema [Transverse Mercator](https://en.wikipedia.org/wiki/Transverse_Mercator_projection) (N,E).|
| `tm2geo()` | Conversión de coordenadas proyectadas [Transverse Mercator](https://en.wikipedia.org/wiki/Transverse_Mercator_projection) (N,E) a [coordenadas geodésicas](https://en.wikipedia.org/wiki/Geodetic_coordinates) (&varphi;, &lambda;). |
| `geo2ecef()` | Conversión de [coordenadas geodésicas](https://en.wikipedia.org/wiki/Geodetic_coordinates) (&varphi;, &lambda;, h) a [coordenadas cartesianas geocéntricas tridimensionales](https://en.wikipedia.org/wiki/Earth-centered,_Earth-fixed_coordinate_system) (X,Y,Z). |
| `ecef2geo()` | Conversión de [coordenada cartesianas geocéntricas tridimensionales](https://en.wikipedia.org/wiki/Earth-centered,_Earth-fixed_coordinate_system) (X,Y,Z) a [coordenadas geodésicas](https://en.wikipedia.org/wiki/Geodetic_coordinates) (&varphi;, &lambda;, h).|

## Ejemplos

Obtener parámetros del elipsoide GRS80:

```matlab
GRS80 = ellipsoid(7019)
GRS80 =
  struct with fields:

           SemiMajorAxis: 6378137
       InverseFlattening: 298.2572
                    Name: 'GRS 1980'
             Description: "Adopted by IUGG 1979 Canberra.  Inverse flattening is derived from geocentric gravitational constant GM = 3986005e8 m*m*m/s/s; dynamic form factor J2 = 108263e-8 and Earth's angular velocity = 7292115e-11 rad/s."
           SemiMinorAxis: 6.3568e+06
    PolarRadiusCurvature: 6.3996e+06
       FirstExcentricity: 0.0818
      SecondExcentricity: 0.0821
     AngularExcentricity: 0.0819
      LinealExcentricity: 1.8244e+06
                       m: 0.0034
                       n: 0.0017
```

Convertir coodenadas geodésicas a coordenadas UTM, en sistema WGS84 (EPSG: 7030),

```matlab
WGS84 = ellipsoid(7030);
FN = 10000000;
FE = 50000;
MC = -69;
K0 = 0.9996;
[north, east] = geo2tm(-27.48952286, -70.38577473, WGS84, MC, K0, FN, FE)
north =
  6958579.443
east =
  363102.736
```

Convertir coordenadas UTM a coordenadas geodésicas, en sistema WGS84,

```matlab
WGS84 = ellipsoid(7030);
FN = 10000000;
FE = 50000;
MC = -69;
K0 = 0.9996;
[lat, lon] = tm2geo(6958579.443, 363102.736, WGS84, MC, K0, FN, FE)
lat =
  -27.4895228552174
lon =
  -70.3857747273678
```