package com.teo.stoneoptics.item;

import com.teo.stoneoptics.StoneOptics;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.Rarity;
import net.neoforged.bus.api.IEventBus;
import net.neoforged.neoforge.registries.DeferredItem;
import net.neoforged.neoforge.registries.DeferredRegister;

public class ModItems {

    public static final DeferredRegister.Items ITEMS =
            DeferredRegister.createItems(StoneOptics.MODID);

    /** Lente sin pulir: vidrio fundido con forma, todavia turbia. */
    public static final DeferredItem<Item> ROUGH_LENS =
            ITEMS.registerSimpleItem("rough_lens", new Item.Properties());

    /** Lente pulida: ya enfoca. Es la pieza que abre la optica. */
    public static final DeferredItem<Item> POLISHED_LENS =
            ITEMS.registerSimpleItem("polished_lens",
                    new Item.Properties().rarity(Rarity.UNCOMMON));

    /** Telescopio: lente pulida montada en un tubo de cobre. */
    public static final DeferredItem<TelescopeItem> TELESCOPE =
            ITEMS.register("telescope",
                    () -> new TelescopeItem(new Item.Properties().stacksTo(1)));

    public static void register(IEventBus modEventBus) {
        ITEMS.register(modEventBus);
    }
}
