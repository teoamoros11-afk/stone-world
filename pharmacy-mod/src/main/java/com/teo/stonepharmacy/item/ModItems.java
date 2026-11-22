package com.teo.stonepharmacy.item;

import com.teo.stonepharmacy.StonePharmacy;
import net.minecraft.world.item.Item;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.neoforge.registries.DeferredItem;
import net.neoforged.neoforge.registries.DeferredRegister;

public final class ModItems {

    public static final DeferredRegister.Items ITEMS =
            DeferredRegister.createItems(StonePharmacy.MODID);

    /** Principio activo: el polvo que la serie fabrica en la era 2. */
    public static final DeferredItem<Item> SULFAMIDA =
            ITEMS.registerSimpleItem("sulfamida", new Item.Properties());

    /** Jeringa: aplica la sulfamida. Se gasta, por eso apila de 8 en 8. */
    public static final DeferredItem<Item> JERINGA =
            ITEMS.registerItem("jeringa", SyringeItem::new, new Item.Properties().stacksTo(8));

    private ModItems() {
    }

    public static void register(IEventBus bus) {
        ITEMS.register(bus);
    }
}
