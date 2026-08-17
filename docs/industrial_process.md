# Overview of the industrial processes

The end products are aluminum profiles, either raw or coated (painted).

To produce them, multiple processes take place, under specific ranges of temperature, pressure, timing and other parameters.

The main ones:
- **Extrusion**: heating of raw aluminum (billet), pressing (the extrusion itself), then profile cut, stretch and aging (hardening)
- **Painting|Coating**: cleanup and surface preparation, then coating and curing

## The main processes

### Extrusion

The raw material is the billet: a solid aluminum cylinder, pressed against a die, to produce a desired profile shape

```mermaid
flowchart LR
    billet(["Raw<br/>Billet"])
    subgraph prep["Billet preparation"]
        direction TB
        cutting["Cut"]
        heating["Heat"]
        cutting --> heating
    end
    pressing["Press<br/>(Extrusion)"]
    subgraph handling["Profile handling"]
        direction TB
        firstcut["Cut<br/>(to calculated<br/>table length)"]
        stretching["Stretching"]
        finalcut["Cut<br/>(to profile length)"]
        loading["Load<br/>(into basket)"]
        firstcut --> stretching --> finalcut --> loading
    end
    aging["Age<br/>(hardening)"]
    profile(["Raw<br/>Aluminum Profile"])

    billet --> prep --> pressing --> handling --> aging --> profile
```

#### What gets tracked

- **Billet size**: calculated so the resulting profile comes out to the right length
- **Billet entry / profile exit temperature**: both measured, since extrusion needs specific temperature ranges to work correctly
- **Die preheat temperature**: dies need to be preheated to a specific range before use; mismatch causes surface defects and shortens die life
- **Ram (extrusion) speed**: too fast causes surface tearing, too slow hurts throughput
- **Butt weight and cutoffs**: the material lost at the end of each billet, to calculate yield
- **Profile output length**: checked against computed target, necessary to adjust future calculations
- **Actual profile count**
- **Linear weight of a profile sample**: compared against a theoretical target
- **Aging oven time and temperature**: not just the resulting hardness, but the parameters that produced it
- **Hardness after aging**: checked to confirm aging worked — if it didn't, it means the extrusion press wasn't kept within the required pressure/temperature ranges

### Painting|Coating

Here the raw materials are the uncoated aluminum profiles (already aged), the chemicals used for the baths before painting, and the electrostatic paint powder

```mermaid
flowchart LR
    profile(["Raw<br/>Aluminum Profile"])
    subgraph prep["Surface preparation"]
        direction TB
        soaking["Water<br/>Soak"]
        degreasing["Degrease<br/>Bath"]
        etching["Etch<br/>Bath"]
        drying["Dry"]
        soaking --> degreasing --> etching --> drying
    end
    coating["Electrostatic<br/>Coat"]
    curing["Cure<br/>(Coating Bake)"]
    coatedprofile(["Coated<br/>Aluminum Profile"])

    profile --> prep --> coating --> curing --> coatedprofile
```

#### What gets tracked

- **Bath temperature**
- **Bath acidity and chemical concentration**: measured via chemical test 
- **Furnace belt speed and temperature**
- **Coating thickness**

## Other processes

There were side processes that also needed to be tracked, for effective production management, namely:

- Dies <details>
    <summary>(What the billet flows through)</summary>

    Dies are what give the profile its shape. Extrusion takes place when the billet (already cut and heated) is pressed against the die set (it consists of more parts actually, to ensure structural stability; ultimately, to be able to withstand the extrusion conditions without breaking): the die itself has a hole (roughly) in the shape of the profile.

    There are two types of profiles (hence, two types of die-sets):
    - Solid (with just one outer surface)
    - Hollow (with an outer surface and one or more inner surfaces)

    Dies are very sensitive, and die preparation can mark the difference between a productive and a lost day of production.

    They need to be cleaned, brushed and polished on the inside with care and, more importantly, they have a limit on how much they can extrude before needing another hardening: the "nitriding" process.

    All of this needs to be tracked carefully (properly logged and inventoried, keeping a "life log" of each die) to ensure the longest possible lifespan of the die tooling while maximizing production.

    Related to this, the linear weight of the profile also constraints the lifespan of a die: if too high, relative to the target (theoretical) value, it signals that the die should be discarded
</details>

- Pre-coating baths <details>
    <summary>(That take place before the electrostatic coating process)</summary>

    After extrusion and before the painting process takes place, the "bath" pool conditions are carefully tracked: this also marks the difference between a good quality, well adhering coating and one that peels off or comes out looking rough or with other defects
</details>

- Customer orders and profile inventory <details>
    <summary>(...Needless to say...)</summary>

    The existing profile inventory needs to be tracked so that production can be prioritized, based on the unfulfilled orders and available dies

    Requests are marked as completed once they are packaged and delivered
</details>