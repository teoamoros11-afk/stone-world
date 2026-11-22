package com.teo.stoneindustry.block.entity;

import net.minecraft.core.BlockPos;
import net.minecraft.core.HolderLookup;
import net.minecraft.nbt.CompoundTag;
import net.minecraft.world.level.block.entity.BlockEntity;
import net.minecraft.world.level.block.state.BlockState;
import net.neoforged.neoforge.energy.EnergyStorage;

/**
 * Buffer de la dinamo: 40.000 FE de capacidad, 8 FE por tick mientras alguien gira.
 * Cada clic derecho son 200 ticks (10 s) de giro; con la manivela se puede acumular.
 */
public class CrankDynamoBlockEntity extends BlockEntity {

    public static final int CAPACIDAD = 40000;
    public static final int FE_POR_TICK = 8;
    public static final int TICKS_POR_CLIC = 200;
    public static final int TICKS_MAXIMOS = 1200;

    private int ticksGirando;
    private final EnergyStorage energy = new EnergyStorage(CAPACIDAD, 2000, 2000, 0);

    public CrankDynamoBlockEntity(BlockPos pos, BlockState state) {
        super(ModBlockEntities.CRANK_DYNAMO.get(), pos, state);
    }

    public EnergyStorage getEnergy() {
        return energy;
    }

    /** Girar la manivela a mano: suma vueltas al buffer. */
    public void crank() {
        ticksGirando = Math.min(ticksGirando + TICKS_POR_CLIC, TICKS_MAXIMOS);
        setChanged();
    }

    public void serverTick() {
        if (ticksGirando > 0) {
            ticksGirando--;
            energy.receiveEnergy(FE_POR_TICK, false);
            setChanged();
        }
    }

    public int getTicksGirando() {
        return ticksGirando;
    }

    @Override
    protected void saveAdditional(CompoundTag tag, HolderLookup.Provider registries) {
        super.saveAdditional(tag, registries);
        tag.putInt("TicksGirando", ticksGirando);
        tag.putInt("Energia", energy.getEnergyStored());
    }

    @Override
    protected void loadAdditional(CompoundTag tag, HolderLookup.Provider registries) {
        super.loadAdditional(tag, registries);
        ticksGirando = tag.getInt("TicksGirando");
        energy.receiveEnergy(tag.getInt("Energia"), false);
    }
}
