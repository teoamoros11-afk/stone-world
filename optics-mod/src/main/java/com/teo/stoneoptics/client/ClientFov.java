package com.teo.stoneoptics.client;

import com.teo.stoneoptics.StoneOptics;
import com.teo.stoneoptics.item.ModItems;
import net.minecraft.client.player.LocalPlayer;
import net.neoforged.api.distmarker.Dist;
import net.neoforged.bus.api.SubscribeEvent;
import net.neoforged.fml.common.EventBusSubscriber;
import net.neoforged.neoforge.client.event.ComputeFovModifierEvent;

/**
 * Solo cliente: estrecha el campo de vision mientras se usa el telescopio.
 * 0.15 = mismo zoom aproximado que el catalejo de vanilla.
 */
@EventBusSubscriber(modid = StoneOptics.MODID, bus = EventBusSubscriber.Bus.GAME, value = Dist.CLIENT)
public final class ClientFov {

    private static final float TELESCOPE_ZOOM = 0.15F;

    private ClientFov() {
    }

    @SubscribeEvent
    public static void onComputeFov(ComputeFovModifierEvent event) {
        if (!(event.getPlayer() instanceof LocalPlayer player)) {
            return;
        }
        if (player.isUsingItem() && player.getUseItem().is(ModItems.TELESCOPE.get())) {
            event.setNewFovModifier(TELESCOPE_ZOOM);
        }
    }
}
